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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.5.0/forge-aarch64-macos.tar.gz"
      sha256 "c49368802a4dc3e1d048d5ce4734e4c5e7e6099c2b4cb461ee48d84a32994e7e"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.5.0/forge-x86_64-macos.tar.gz"
      sha256 "7439e7b723702b181ae600f75cfc33076180257102692c43981c0dce150169a1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.5.0/forge-aarch64-linux.tar.gz"
      sha256 "16657c04f1c4ba13f93172ec037332b84439ca26df933f7b43a5cdcc639ee3fa"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.5.0/forge-x86_64-linux.tar.gz"
      sha256 "694a1e81a066a0a3594d6ec8da326877726c1b52a71475b92f394aa1c76c151c"
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
