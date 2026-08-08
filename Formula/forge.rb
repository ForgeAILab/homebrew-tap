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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.6.1/forge-aarch64-macos.tar.gz"
      sha256 "d38b43015e7a68f1a6d373704cf4ac56477a8e11cfd453ade571f772cd105b6c"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.6.1/forge-x86_64-macos.tar.gz"
      sha256 "375ea6e8e2bae321f4dcf328a63e81ada5338c67b108b78bf583234ed2d05b04"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.6.1/forge-aarch64-linux.tar.gz"
      sha256 "3225151baa126e516effbc39b1a86e56e7a3178bb079c88326a36f530968c058"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.6.1/forge-x86_64-linux.tar.gz"
      sha256 "de8438366eb2ff06ac82b397033ee7d35d67d0a90080a210c3a0ef18c34fac8f"
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
