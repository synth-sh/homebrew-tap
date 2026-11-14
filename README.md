# Synth Homebrew tap

Install the [Synth CLI](https://github.com/synth-sh/synth) on Apple Silicon
macOS or on arm64 and x86-64 Linux:

```sh
brew install synth-sh/tap/synth
```

Once [Synth Desktop](https://github.com/synth-sh/desktop) publishes its first
stable release and the cask update merges, install it on Apple Silicon with
macOS 26 or later:

```sh
brew install --cask synth-sh/tap/synth-desktop
```

Desktop bundles its pinned Synth engine. Upgrade either package with
`brew upgrade`.

After publishing a stable CLI or Desktop release, open
[Actions → Sync stable releases](https://github.com/synth-sh/homebrew-tap/actions/workflows/sync.yml)
and click **Run workflow**. One run checks both release repositories, downloads
and verifies the published assets for changed packages, and opens or refreshes
a PR for each update. Merge the PR to make the release available through
Homebrew. The tap's Actions settings must allow GitHub Actions to create pull
requests.
