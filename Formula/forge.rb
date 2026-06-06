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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.10/forge-aarch64-macos.tar.gz"
      sha256 "cba4adf72e2e14a2223330b95a0b019a1c06e63d5f72b7c3e830ee6ee27d6272"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.10/forge-x86_64-macos.tar.gz"
      sha256 "9151d97566e00433de6835b949101e7fd445b22772b87e991e078533aaba6838"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.10/forge-aarch64-linux.tar.gz"
      sha256 "22268f84803b9f78c1ea202d39cb462147d034c343e2001499f50c9f06fa4e8f"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.10/forge-x86_64-linux.tar.gz"
      sha256 "9b112fe10db23bc14d7c4edaf0bfde13cce052772a8b5ac4d602eb4548705a27"
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
