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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.0/forge-aarch64-macos.tar.gz"
      sha256 "41c1be5f6e450103c35fb31d6595ddb815348ae6eaefd5d2dc13bbaa77c56a22"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.0/forge-x86_64-macos.tar.gz"
      sha256 "cafc83949247f9db38bad8c9d5a82edfc21d82a6b87e735908afef2366d2ae89"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.0/forge-aarch64-linux.tar.gz"
      sha256 "0333b1123268df8a690c6969b5934cf710bb9c642a686d4388c53534b09ab808"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.0/forge-x86_64-linux.tar.gz"
      sha256 "e26ebf00cab85315eeba8074fc9936d72bb25272ec818036eb45e1fcb1952609"
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
