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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.3/forge-aarch64-macos.tar.gz"
      sha256 "a66a117df57ede2e0ffdcd4bd391fddb986dee224db429e83be21dab43273df1"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.3/forge-x86_64-macos.tar.gz"
      sha256 "ea0e648bc2881535a3db15152f960dfa46406c866903b1651989b55a11eb431a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.3/forge-aarch64-linux.tar.gz"
      sha256 "4dda5d6375c4095b07ede0f8ac1cfc975f8f920a897671b9adc1dd1de92a9061"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.3/forge-x86_64-linux.tar.gz"
      sha256 "6e657bde5d5e6cfee2a1924110fa1c009320f1dd4a85b022a368ff7c9ac7ed84"
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
