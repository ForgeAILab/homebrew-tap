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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.9.2/forge-aarch64-macos.tar.gz"
      sha256 "bdda77553bf0bad5dadfdffd9c0041b478264b35dec705f263d05e2300c3f0bc"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.9.2/forge-x86_64-macos.tar.gz"
      sha256 "0ed427c2c15cdbec8b78c0e82890cfe7aa4b64c294ce55c8538782dd78eb1845"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.9.2/forge-aarch64-linux.tar.gz"
      sha256 "543d7f45e8df7dce4cf4dd8529f0afa8b764901f2c2338322b035240f181f793"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.9.2/forge-x86_64-linux.tar.gz"
      sha256 "0e4a219f0761f1064286dc32554ea4d0de59491d6b7c822052347c210c161b50"
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
