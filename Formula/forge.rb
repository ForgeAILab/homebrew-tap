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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.4/forge-aarch64-macos.tar.gz"
      sha256 "045ff1b35a8bdcb3df00dca8e30d3036fef3045bb58949849cb4e44b7fd760a3"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.4/forge-x86_64-macos.tar.gz"
      sha256 "7fdab33304fab9225f5bbcf245c76fea7022690523f1a095e281cb2b42175b12"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.4/forge-aarch64-linux.tar.gz"
      sha256 "fc3df8f644811475d98f1df5cd44cc51b8c2fe1606e238d02df52fda929e5a16"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.4/forge-x86_64-linux.tar.gz"
      sha256 "d74598e3c68023eaa8b4556a4b03dfb9f4562aa38392bda39817f822a93dfc20"
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
