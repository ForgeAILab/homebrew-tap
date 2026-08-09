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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.2/forge-aarch64-macos.tar.gz"
      sha256 "d55ac988f7210891ebcf0828a3ad3faf38dfdc4151b7f787ab0abdf1eeebcc26"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.2/forge-x86_64-macos.tar.gz"
      sha256 "866ec1a314691df0b21e813543d10c98ba3a995691146a12fb5a3b117566d20e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.2/forge-aarch64-linux.tar.gz"
      sha256 "20e16d5cca3481c3d95e82589bc15bfb3d7f99d0bedd26f1651d7f9c419ef2a2"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.2/forge-x86_64-linux.tar.gz"
      sha256 "8952c73c51607e427160bddaedcf2c1d7066655950b6229b2bfbb762e1a2c200"
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
