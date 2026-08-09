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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.0/forge-aarch64-macos.tar.gz"
      sha256 "73447028e4aceb7b11206cbe358e6ae404cab761b6736f69b42785dd711964d7"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.0/forge-x86_64-macos.tar.gz"
      sha256 "c741573d098ce7b9982214ec847e915b6917f10b534f06fc0a4ca252cd3f3ac2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.0/forge-aarch64-linux.tar.gz"
      sha256 "d6ee2855502c9da22c17e6f785b163ffe896514bc4531a23248c3987c672b78f"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.0/forge-x86_64-linux.tar.gz"
      sha256 "788173eae8db22b1b9624c1d9e437c5907e2ad05793630679e35f5d2e18e3dbb"
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
