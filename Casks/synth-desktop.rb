cask "synth-desktop" do
  version "0.2.1"
  sha256 "3cb504f8ab27664a29678b7babec465c1e533a9200f83a372d965039e62bb967"

  url "https://github.com/synth-sh/desktop/releases/download/v#{version}/synth-desktop-#{version}-macos-arm64.zip"
  name "Synth"
  desc "Native macOS client for the Synth coding agent"
  homepage "https://github.com/synth-sh/desktop"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Synth.app"
end
