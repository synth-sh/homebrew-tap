cask "synth-desktop" do
  version "0.2.3"
  sha256 "90226df1b3458840557bdf3a75e07bdea28d97e678e5128c09a33f32d5a6df73"

  url "https://github.com/synth-sh/desktop/releases/download/v#{version}/synth-desktop-#{version}-macos-arm64.zip"
  name "Synth"
  desc "Native macOS client for the Synth coding agent"
  homepage "https://github.com/synth-sh/desktop"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Synth.app"
end
