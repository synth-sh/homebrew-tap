class Synth < Formula
  desc "Terminal coding agent for local and hosted models"
  homepage "https://github.com/synth-sh/synth"
  version "0.2.2"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/synth-sh/synth/releases/download/v#{version}/synth-#{version}-aarch64-macos.tar.gz"
    sha256 "096f69546bac1f6e452f85ea033ba2cf6ed77ac2880b7c092f3cd5a863afd119"
  end

  on_linux do
    on_arm do
      url "https://github.com/synth-sh/synth/releases/download/v#{version}/synth-#{version}-aarch64-linux-musl.tar.gz"
      sha256 "7d125a274ea3ed7119b5a337ea01a203cc285d2d5e1e26ddf3b8be61becc1ed7"
    end

    on_intel do
      url "https://github.com/synth-sh/synth/releases/download/v#{version}/synth-#{version}-x86_64-linux-musl.tar.gz"
      sha256 "0ea005ff77ea1a135002b07561d863878e9437c3e6a8c9ade9739f30a512d733"
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
