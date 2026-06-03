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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.7/forge-aarch64-macos.tar.gz"
      sha256 "005f5695464fcebb4279739590ff0f3a99a8d9dfc1834b9a20da475a688ac4b4"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.7/forge-x86_64-macos.tar.gz"
      sha256 "f088489a812a4aae6c9060366093aabf38a6beab701ed3bc8fe7973c508825af"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.7/forge-aarch64-linux.tar.gz"
      sha256 "39eee95d1adb21f53eb3c43bd891bf59701be5a977e4938cb4b726f1eae94398"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.7/forge-x86_64-linux.tar.gz"
      sha256 "6fab8ce22ba2d8ad4ea1ea2e28a21459bfb66eae7798a8a98d2a4699746624cb"
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
