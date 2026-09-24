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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.1/forge-aarch64-macos.tar.gz"
      sha256 "3cd5e2cb62e80d8b9168975b569b143626baaa00b4383afccc879372f5e9067b"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.1/forge-x86_64-macos.tar.gz"
      sha256 "6e8fea4a153c20f8d93927a762df250f7f516b35e4c5b5849550ae4be5c3c411"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.1/forge-aarch64-linux.tar.gz"
      sha256 "7d43d9c6d3c1d1552b8935fe31b5767297a3a7fd468ebbf2c746490898edc035"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.1/forge-x86_64-linux.tar.gz"
      sha256 "5b8cb5e38ca9c8c1f6519a32648f0ce24d0b5ce1149141ca7d0ad141f671fddc"
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
