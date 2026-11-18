cask "synth-desktop" do
  version "0.1.1"
  sha256 "d8982bb398bc6552b5cedc4863980cb3714a162b650135ab1c4aba1b124f2adc"

  url "https://github.com/synth-sh/desktop/releases/download/v#{version}/synth-desktop-#{version}-macos-arm64.zip"
  name "Synth"
  desc "Native macOS client for the Synth coding agent"
  homepage "https://github.com/synth-sh/desktop"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Synth.app"
end
