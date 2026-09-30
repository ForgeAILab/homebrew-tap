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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.10/forge-aarch64-macos.tar.gz"
      sha256 "287041839b684a09807d22a32c05ce1278d376b15cd8ba241ff19b5800db51a7"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.10/forge-x86_64-macos.tar.gz"
      sha256 "8ec7c943e4c29febcfced2510fab551446ef0743ae74ae8e7ccced0ec664e98f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.10/forge-aarch64-linux.tar.gz"
      sha256 "54a749a12e0d5a80d27fdb63a681de1ed8641519c6a933133e0b2921aa60e5ea"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.10/forge-x86_64-linux.tar.gz"
      sha256 "7a6735d7cf8f790b0a6dd0a7d22faed9a44b139eaee6965d89fcaf41e6f2525a"
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
