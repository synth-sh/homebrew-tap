cask "synth-desktop" do
  version "0.1.0"
  sha256 "9973170888f7c81bd61710e6fb304c9ddf0a5a7790d8c2e9b16025f16374a903"

  url "https://github.com/synth-sh/desktop/releases/download/v#{version}/synth-desktop-#{version}-macos-arm64.zip"
  name "Synth"
  desc "Native macOS client for the Synth coding agent"
  homepage "https://github.com/synth-sh/desktop"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Synth.app"
end
