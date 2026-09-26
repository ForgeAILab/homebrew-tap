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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.3/forge-aarch64-macos.tar.gz"
      sha256 "0fc64d869291a010eb820fc358fb71a4fade3374e3dad99edeb3ae23b135ef82"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.3/forge-x86_64-macos.tar.gz"
      sha256 "e3f1d4b40bfa2df9998b3ed894ed3c4b2dbbfae8b3593e97a816b6b5ea6104ac"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.3/forge-aarch64-linux.tar.gz"
      sha256 "b729603238382235e69b047f9a180945305cb7e0409a10bf96783bd3d8a16365"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.3/forge-x86_64-linux.tar.gz"
      sha256 "9e3fa7c8c3184ec73acecfa4617fc4669b342f70b4c19059c905126a0eecb8ae"
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
