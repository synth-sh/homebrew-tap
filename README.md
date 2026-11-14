# Synth Homebrew tap

Install the [Synth CLI](https://github.com/synth-sh/synth) on Apple Silicon
macOS or x86-64 Linux:

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

The **Sync stable releases** workflow checks both release repositories every
30 minutes. It can also be run from the Actions tab after a release. Each
package has its own update PR. The workflow downloads the published assets and
checks their SHA-256 digests before proposing the update. Merge the PR to make
the release available through Homebrew. The tap's Actions settings must allow
GitHub Actions to create pull requests.

GitHub disables scheduled workflows in public repositories after 60 days
without repository activity. If that happens, re-enable the schedule from the
Actions tab and run the workflow manually to catch up.

## Run the sync immediately after each release

Install an organization-owned GitHub App on `synth-sh/homebrew-tap` only.
Grant it repository **Actions: Read and write** so it can dispatch the sync
workflow. Make the App's client ID available as the Actions variable
`HOMEBREW_APP_CLIENT_ID` and its private key as the Actions secret
`HOMEBREW_APP_PRIVATE_KEY` in `synth-sh/synth` and `synth-sh/desktop`.
With the variable set, each stable release dispatches the sync after publishing.
