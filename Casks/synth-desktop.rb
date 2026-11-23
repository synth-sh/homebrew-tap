cask "synth-desktop" do
  version "0.2.2"
  sha256 "80986ea8e09a9a1208a3469f5eebfea7642d7550640447c5274ca7bab6158482"

  url "https://github.com/synth-sh/desktop/releases/download/v#{version}/synth-desktop-#{version}-macos-arm64.zip"
  name "Synth"
  desc "Native macOS client for the Synth coding agent"
  homepage "https://github.com/synth-sh/desktop"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Synth.app"
end
