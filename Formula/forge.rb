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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.5/forge-aarch64-macos.tar.gz"
      sha256 "1f9ae1b364837087ba866a2d4e84441e277b6d6238bf77fd1007994ba28b51a8"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.5/forge-x86_64-macos.tar.gz"
      sha256 "17ea39e51839c5259579d72d12fe43b8c41f1823b60e8448cae8e67d50decd53"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.5/forge-aarch64-linux.tar.gz"
      sha256 "12d3517077617cc5ce0cd6d24288169c73d6fa53266d843568d730a25034681c"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.5/forge-x86_64-linux.tar.gz"
      sha256 "71811614a9b25b2f3cb569958035f7925b24218bce18dcecd5a71cf5b3948555"
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
