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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.7/forge-aarch64-macos.tar.gz"
      sha256 "e8c1e624dd74920088e4e9242f3d928a6b07475c4de54705e4f3ccc8ce584706"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.7/forge-x86_64-macos.tar.gz"
      sha256 "d2715bd243e33659df311b78dcb97e1d40465ffa7b18fa2ba0985d9b70166908"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.7/forge-aarch64-linux.tar.gz"
      sha256 "43918e8b36abd28815ae4d5dcd7ef84711e4f062f7ad5bfae1f2322666aefdb1"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.7/forge-x86_64-linux.tar.gz"
      sha256 "525ab97f545a735e130e904500f0eaa9e0ff0e20369b7be8dfd7ca4572278f5c"
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
