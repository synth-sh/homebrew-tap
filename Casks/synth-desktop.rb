cask "synth-desktop" do
  version "0.2.4"
  sha256 "82afcdc32bd44616ad5bb8d41546c3826b48140b4c32988fe6e694556967bba6"

  url "https://github.com/synth-sh/desktop/releases/download/v#{version}/synth-desktop-#{version}-macos-arm64.zip"
  name "Synth"
  desc "Native macOS client for the Synth coding agent"
  homepage "https://github.com/synth-sh/desktop"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Synth.app"
end
