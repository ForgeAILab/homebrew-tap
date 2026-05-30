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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.5/forge-aarch64-macos.tar.gz"
      sha256 "31b8c8313040f856e3a6ceb640b6dff4ed5f6b43ea9ca07e7624562edd5c3985"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.5/forge-x86_64-macos.tar.gz"
      sha256 "00adf65a7f662eec8dbc4b89d803b1b86228f0c0012f8cb86eaeedc44e342a61"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.5/forge-aarch64-linux.tar.gz"
      sha256 "4e99cd3365865f92e378198a32c61fa83732cfed66e47db7056234191f56f81c"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.1.5/forge-x86_64-linux.tar.gz"
      sha256 "d9d83e1409dfefb62d38c1ae3f2aaa91480ab6ba18a21b46eb04c36f548c4abe"
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
