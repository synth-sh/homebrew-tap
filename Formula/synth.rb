class Synth < Formula
  desc "Terminal coding agent for local and hosted models"
  homepage "https://github.com/synth-sh/synth"
  version "0.2.3"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/synth-sh/synth/releases/download/v#{version}/synth-#{version}-aarch64-macos.tar.gz"
    sha256 "b92d2f01a072e24491fbdbbbe66ccd5d1168be0e9eca8f43626e2adfcda5e59e"
  end

  on_linux do
    on_arm do
      url "https://github.com/synth-sh/synth/releases/download/v#{version}/synth-#{version}-aarch64-linux-musl.tar.gz"
      sha256 "c1b6ed0d45122166f7567407dcef32146edd62a655cb6e72004a8c2bde338860"
    end

    on_intel do
      url "https://github.com/synth-sh/synth/releases/download/v#{version}/synth-#{version}-x86_64-linux-musl.tar.gz"
      sha256 "6f13f999811bd0b598dd0b7d7de9faac9dc04dc1579ffa883329c2e2f8f120a3"
    end
  end

  def install
    bin.install "synth"
  end

  test do
    assert_match "synth #{version}", shell_output("#{bin}/synth --version")
    assert_match "synth [project]", shell_output("#{bin}/synth --help")
  end
end
