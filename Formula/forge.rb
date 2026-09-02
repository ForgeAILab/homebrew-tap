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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.9.0/forge-aarch64-macos.tar.gz"
      sha256 "1ad4427dfc2349345a35901d31e79a993aaf19c5d39a2b62febd100a4e0128fa"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.9.0/forge-x86_64-macos.tar.gz"
      sha256 "86674593e2d54f80bc1d99e05003c3e6383e9be39c18aeee0327d5c55344b15d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.9.0/forge-aarch64-linux.tar.gz"
      sha256 "516c70f2a7b16d03fc0da6100cda5095cdb5d8758dd3e70d2ccb17223a9a333a"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.9.0/forge-x86_64-linux.tar.gz"
      sha256 "50083549ff2378d717af203fd2edf6c5cbe467388e2c69cc5d8ee11c3d317cdf"
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
