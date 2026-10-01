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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.12/forge-aarch64-macos.tar.gz"
      sha256 "821d551d7a5aae3d833bd6949f5f15796b91d125ba644466e9060ae1f7803ca1"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.12/forge-x86_64-macos.tar.gz"
      sha256 "5bb4a71afc91a3b00b66d7a40a7bc70d87f4a0dc1819b2acd40fc2e91ec47069"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.12/forge-aarch64-linux.tar.gz"
      sha256 "4e0a00230c298a1f4d596e605ed1a9433f146177f515db80433e40d2bd4471f6"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.12/forge-x86_64-linux.tar.gz"
      sha256 "3b3772b410f69e5dbafc6acbc5ea3a5a69138c3b3f01235dee98ddc75ea83d10"
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
