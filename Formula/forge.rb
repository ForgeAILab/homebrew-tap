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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.9/forge-aarch64-macos.tar.gz"
      sha256 "90199140a154c44496f74de83ae433f76f3cd69a53ecf2e89fe86afe2d9a7b5c"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.9/forge-x86_64-macos.tar.gz"
      sha256 "8a8f138bb25d982bbf75ea9c6c8f7fff11e240c642a84d7f08d56708c1d450b6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.9/forge-aarch64-linux.tar.gz"
      sha256 "ca3fd6b9babe2bb5db9e96dd025a15dab7d60ea25fe53768f90b619e81988009"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.9/forge-x86_64-linux.tar.gz"
      sha256 "2a83e2f31935c80bec6ab9d8299d3619d79dfe864467dd9ecc8c9c41baf849ba"
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
