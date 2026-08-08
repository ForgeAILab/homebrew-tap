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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.6.0/forge-aarch64-macos.tar.gz"
      sha256 "d7ec8524a55bc2dd0309f24bc853d3c9ae9454cde805ee3418174250742936b4"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.6.0/forge-x86_64-macos.tar.gz"
      sha256 "914b567924efb9579c6d46acb81e6e8a4f37b6d1f3be1d765555cfee9bb974a5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.6.0/forge-aarch64-linux.tar.gz"
      sha256 "cc288e313e5bff5a9417188e2a21fab3defea98bb77f99b32d6c0abdbc456deb"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.6.0/forge-x86_64-linux.tar.gz"
      sha256 "7e2d7bf3d0309c89ada7d2d7c4e39252c5f029b7c6c5c52f2eab6c8b6366805b"
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
