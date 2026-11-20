cask "synth-desktop" do
  version "0.2.0"
  sha256 "f054fe6f7075d72c1cf9bc045703fa062f3997c0d734fee775588f9381b7ece7"

  url "https://github.com/synth-sh/desktop/releases/download/v#{version}/synth-desktop-#{version}-macos-arm64.zip"
  name "Synth"
  desc "Native macOS client for the Synth coding agent"
  homepage "https://github.com/synth-sh/desktop"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Synth.app"
end
