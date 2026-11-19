cask "synth-desktop" do
  version "0.1.2"
  sha256 "95314c6fe7aebddf326aec97e82fc6c705b4665a2d3a988e51e2d1997040470b"

  url "https://github.com/synth-sh/desktop/releases/download/v#{version}/synth-desktop-#{version}-macos-arm64.zip"
  name "Synth"
  desc "Native macOS client for the Synth coding agent"
  homepage "https://github.com/synth-sh/desktop"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Synth.app"
end
