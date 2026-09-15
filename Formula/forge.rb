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
      url "https://github.com/ForgeAILab/forge/releases/download/v0.12.0/forge-aarch64-macos.tar.gz"
      sha256 "dc1a45f5ec52a05504a3f0efd95a8005271110daa7db6ac3814aa3948afe5d76"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.12.0/forge-x86_64-macos.tar.gz"
      sha256 "3d558a723df1a04b0adfc9d2d4ccefbcb4f934e5f478717bb443024d18850307"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v0.12.0/forge-aarch64-linux.tar.gz"
      sha256 "0ea7102779a4915f20a1518f32d656c387b002354bcc92c58db528e1dd3cf165"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v0.12.0/forge-x86_64-linux.tar.gz"
      sha256 "df9425bbc2645b65c732e59bacffca03bf42ed50a092f06b70a9929dd85b7dc7"
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
