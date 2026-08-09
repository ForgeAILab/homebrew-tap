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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.1/forge-aarch64-macos.tar.gz"
      sha256 "514768efc85b504fa5504166dbfd4f2ba5d1f0c8b912e45ae5bcc20448578f13"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.1/forge-x86_64-macos.tar.gz"
      sha256 "45b07a3e079adbd336525432ab48e375dc70b574820bc9091b07d4df76242fa4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.1/forge-aarch64-linux.tar.gz"
      sha256 "5eaef98766140ae6875c8034a75695d740be26b80b79e285aa02346318436047"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.7.1/forge-x86_64-linux.tar.gz"
      sha256 "db3cf54e670421c4cc07e26f7892dabe9c8d33aca3e6d749682cfba70afeee52"
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
