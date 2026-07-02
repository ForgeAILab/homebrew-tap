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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.2.0/forge-aarch64-macos.tar.gz"
      sha256 "dedf853838ebef8d659fe4e5db38ed14edb3ba0e930b7e57dca70e30915f904e"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.2.0/forge-x86_64-macos.tar.gz"
      sha256 "a93075ae1195f3d76d52d799524f25f836dcbe0e470c6d93936fb40b8d747e21"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.2.0/forge-aarch64-linux.tar.gz"
      sha256 "2dba31f92b66ea48b3357f2cbb98153df70fa53cf4097871730415dbbf5d6231"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.2.0/forge-x86_64-linux.tar.gz"
      sha256 "fae9ea0bf1d45362deb67ecd0dd45b75033cef99cee6de01bce2ec24b85aade0"
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
