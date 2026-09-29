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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.9/forge-aarch64-macos.tar.gz"
      sha256 "d59b5c717d7f2450f6c8a0f591b54258f931354bc8ba6640bad58ac531da81d1"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.9/forge-x86_64-macos.tar.gz"
      sha256 "a48c59da029c825450f1dc40f15ba798ebff8b777878c75ef5e6bb747384c594"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.9/forge-aarch64-linux.tar.gz"
      sha256 "95bdcdcbf25a142dbdd845c13136dd25f08c11b3fc3e6363f5a9dd77f16bf2ee"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.13.9/forge-x86_64-linux.tar.gz"
      sha256 "05c76ba1daf5804746f6e1566d8893abe9516de6ff7aec3b08f55a68a7c8222b"
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
