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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.8.0/forge-aarch64-macos.tar.gz"
      sha256 "024c61f76d1bdca03c5d6f3ef30863849ca8a040b5741da0cd5b249448bf7968"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.8.0/forge-x86_64-macos.tar.gz"
      sha256 "e6617793b828e1897f313e16e2fd550b642a2cc46718db2a9886b888af341141"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.8.0/forge-aarch64-linux.tar.gz"
      sha256 "b8b04cc4dd9b2017dbc7e78bec07175468d18a775027623d948d16282cd14032"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.8.0/forge-x86_64-linux.tar.gz"
      sha256 "50d77950879f2fd46c14f54488d39cda4a53e89fdd5d679e3c85768cbdaec5d6"
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
