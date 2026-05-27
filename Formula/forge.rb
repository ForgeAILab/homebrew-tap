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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.4/forge-aarch64-macos.tar.gz"
      sha256 "a184ea471d5be144470df42c2bc2ac061d6a4608ffc6ed12bcbfae242f092376"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.4/forge-x86_64-macos.tar.gz"
      sha256 "bf75b39a8a066a6603a5b30e0374e4be2e3d29adaae85189036696e1b35efe2b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.4/forge-aarch64-linux.tar.gz"
      sha256 "230e60e668cb3aca5efcbb2888cd79e84cd631f622f7986168322c8cc0178beb"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.4/forge-x86_64-linux.tar.gz"
      sha256 "6f597366cbe176ecbdd7de7f7a37129c9ec5e1c070aca931045069dc06b58878"
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
