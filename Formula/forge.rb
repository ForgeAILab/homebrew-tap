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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.9.1/forge-aarch64-macos.tar.gz"
      sha256 "a1d7378f1c715707681186a9da4dff55cbc3560314e4521e4b586963d2994276"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.9.1/forge-x86_64-macos.tar.gz"
      sha256 "d7e84e82f096855abe4c30fb638d3516e59c99832d9c27ad14782d044e23a09b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.9.1/forge-aarch64-linux.tar.gz"
      sha256 "b6cc171d70dc1610fd87d95f792ede16eaa91d303a568341a619144ffea3c3bf"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.9.1/forge-x86_64-linux.tar.gz"
      sha256 "7f480c94dc03362b9534103112fb580c15c6a3090d07b9302e964de55a37377f"
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
