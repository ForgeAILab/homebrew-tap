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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.11.0/forge-aarch64-macos.tar.gz"
      sha256 "320444657e662f2345727d0ca22e4370d6674cdc4df8fe891829eb0c0fc056be"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.11.0/forge-x86_64-macos.tar.gz"
      sha256 "2c5908d3c13de0ed8c20cf2ba90f9e85a1c033a818a0751e0a99614bac8cbcc2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.11.0/forge-aarch64-linux.tar.gz"
      sha256 "c8609d78e76bda5212fb6cee4e53812c384a188ad3213970d4c517d5767bfbb6"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.11.0/forge-x86_64-linux.tar.gz"
      sha256 "fb38f7b3cf7651c6e53c34b2c639dc7162895e338f617b4b283317677347ae27"
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
