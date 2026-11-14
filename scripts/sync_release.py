import argparse
import hashlib
import json
import re
import subprocess
from pathlib import Path
from tempfile import TemporaryDirectory


PACKAGES = {
    "synth": ("synth-sh/synth", Path("Formula/synth.rb")),
    "synth-desktop": ("synth-sh/desktop", Path("Casks/synth-desktop.rb")),
}


def stable_version(tag):
    if not re.fullmatch(r"v(?:0|[1-9][0-9]*)(?:\.(?:0|[1-9][0-9]*)){2}", tag):
        raise ValueError(f"Expected a stable release tag, got {tag!r}")
    return tuple(map(int, tag[1:].split(".")))


def gh_json(*args):
    return json.loads(subprocess.check_output(["gh", *args], text=True))


def asset_checksums(repo, tag, names):
    release = gh_json("release", "view", tag, "--repo", repo,
                      "--json", "isDraft,isPrerelease,assets")
    if release["isDraft"] or release["isPrerelease"]:
        raise ValueError(f"{repo} {tag} is not a stable public release")
    assets = {asset["name"]: asset for asset in release["assets"]}

    with TemporaryDirectory() as directory:
        command = ["gh", "release", "download", tag, "--repo", repo, "--dir", directory]
        for name in names:
            if name not in assets:
                raise ValueError(f"{repo} {tag} is missing {name}")
            command.extend(["--pattern", name])
        subprocess.run(command, check=True)
        checksums = []
        for name in names:
            hasher = hashlib.sha256()
            with (Path(directory) / name).open("rb") as archive:
                for chunk in iter(lambda: archive.read(1024 * 1024), b""):
                    hasher.update(chunk)
            sha256 = hasher.hexdigest()
            digest = assets[name].get("digest")
            if digest and digest != f"sha256:{sha256}":
                raise ValueError(f"Release digest mismatch for {name}")
            checksums.append(sha256)
        return checksums


def update(package, tag, path, repo):
    incoming = stable_version(tag)
    old = path.read_text() if path.exists() else ""
    current = re.search(r'^  version "([^"]+)"$', old, re.MULTILINE)
    if (old or package == "synth") and current is None:
        raise ValueError(f"No version in {path}")
    if current and stable_version(f"v{current[1]}") >= incoming:
        return

    version = tag[1:]
    if package == "synth":
        targets = ("aarch64-macos", "aarch64-linux-musl", "x86_64-linux-musl")
        names = [f"synth-{version}-{target}.tar.gz" for target in targets]
        checksums = asset_checksums(repo, tag, names)
        updated = old.replace(current[0], f'  version "{version}"')
        for target, sha256 in zip(targets, checksums):
            suffix = re.escape(f"-{target}.tar.gz")
            pattern = rf'(^ +url "[^"\n]+{suffix}"\n +sha256 ")[0-9a-f]{{64}}("$)'
            updated, count = re.subn(pattern, rf'\g<1>{sha256}\2', updated, flags=re.MULTILINE)
            if count != 1:
                raise ValueError(f"Expected one checksum for {target} in {path}")
    else:
        [sha256] = asset_checksums(repo, tag, [f"synth-desktop-{version}-macos-arm64.zip"])
        updated = f'''cask "synth-desktop" do
  version "{version}"
  sha256 "{sha256}"

  url "https://github.com/synth-sh/desktop/releases/download/v#{{version}}/synth-desktop-#{{version}}-macos-arm64.zip"
  name "Synth"
  desc "Native macOS client for the Synth coding agent"
  homepage "https://github.com/synth-sh/desktop"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Synth.app"
end
'''
    path.parent.mkdir(exist_ok=True)
    path.write_text(updated)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("package", choices=PACKAGES)
    args = parser.parse_args()
    repo, path = PACKAGES[args.package]
    releases = gh_json("release", "list", "--repo", repo, "--exclude-drafts",
                       "--exclude-pre-releases", "--json", "tagName,isLatest")
    latest = next((release["tagName"] for release in releases if release["isLatest"]), None)
    if latest:
        update(args.package, latest, path, repo)
    elif releases or args.package == "synth":
        raise ValueError(f"No latest stable release found for {repo}")
    else:
        print(f"{repo} has no stable release yet")


if __name__ == "__main__":
    main()
