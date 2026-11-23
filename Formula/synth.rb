class Synth < Formula
  desc "Terminal coding agent for local and hosted models"
  homepage "https://github.com/synth-sh/synth"
  version "0.3.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/synth-sh/synth/releases/download/v#{version}/synth-#{version}-aarch64-macos.tar.gz"
    sha256 "cd6744793d813f351e715b87aeae7ac1e8ef4734b41a4b5d564e89c68daf0cc1"
  end

  on_linux do
    on_arm do
      url "https://github.com/synth-sh/synth/releases/download/v#{version}/synth-#{version}-aarch64-linux-musl.tar.gz"
      sha256 "08ce36b1236e2f40536dea717ab4f5f591566a1d51d67751dd23300f117be0e7"
    end

    on_intel do
      url "https://github.com/synth-sh/synth/releases/download/v#{version}/synth-#{version}-x86_64-linux-musl.tar.gz"
      sha256 "5e282d3fbdcb30e2ce9241e22645040a3b310ec8907e02f5a5c6fe565e025497"
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
