# typed: false
# frozen_string_literal: true

# Homebrew formula for Forge — the local-first workflow engine for coding agents.
# Source repo: https://github.com/ForgeAILab/forge
#
# After cutting a new release on the source repo, run
# `scripts/update-checksums.sh <version>` from the tap root. The script updates
# the release URLs and rewrites the four `sha256` lines from the release
# SHA256SUMS file.
class Forge < Formula
  desc "Local-first workflow engine for coding agents"
  homepage "https://github.com/ForgeAILab/forge"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.8/forge-aarch64-macos.tar.gz"
      sha256 "8cd30c583108753d17b9bd7f42a461ab485456bdb9bf8ba9a4957890fea9781a"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.8/forge-x86_64-macos.tar.gz"
      sha256 "ed0a40d63d6e0318d431bab856f4a54d536eee2a501f182ab235cd653492b678"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.8/forge-aarch64-linux.tar.gz"
      sha256 "9477617faf0c1c9f321d76f14a915182d41dcd2e41b8838565558559257c359c"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.8/forge-x86_64-linux.tar.gz"
      sha256 "180946e7abdb82c5fc45f0572c2ba2dc00e56676f2dcf0e36fa2e7bc740768b0"
    end
  end

  def install
    bin.install "forge"
    bin.install "forge-ctl"
    pkgshare.install "web" if Dir.exist?("web")
  end

  def caveats
    <<~EOS
      Forge starts on a loopback port and stores data under ~/.forge/.
      To launch with seeded demo data:
        forge --demo
      Then open the management_url printed in the logs.
    EOS
  end

  test do
    assert_match "Usage: forge", shell_output("#{bin}/forge --help")
    assert_match "Forge CLI client", shell_output("#{bin}/forge-ctl --help")
  end
end
