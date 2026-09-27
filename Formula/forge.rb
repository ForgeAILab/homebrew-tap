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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.6/forge-aarch64-macos.tar.gz"
      sha256 "cb0c2d467cff76558a12eb33885c6b1ad69bc27073e6c5f94ee9ffe001319ad2"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.6/forge-x86_64-macos.tar.gz"
      sha256 "9f76a77c22f072b27ed1b48acc36125d658c543ebf2c72b5d995e7cd646efab5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.6/forge-aarch64-linux.tar.gz"
      sha256 "465064f001491d699d7355c04c84df4c48a0df0cbf9ed844de819d9bedb4a53c"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.6/forge-x86_64-linux.tar.gz"
      sha256 "4068d123d8358e56e951b74d1bf11fba13fb97d7053d7c6b334b35f965fcc2d1"
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
