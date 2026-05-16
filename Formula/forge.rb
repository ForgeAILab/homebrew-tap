# typed: false
# frozen_string_literal: true

# Homebrew formula for Forge — the local-first workflow engine for coding agents.
# Source repo: https://github.com/ForgeAILab/forge
#
# After cutting a new release on the source repo:
#   1. Bump `version` below to the new tag (without the leading `v`).
#   2. Run `scripts/update-checksums.sh <version>` from the repo root — it pulls
#      the published SHA256SUMS file and rewrites the four `sha256` lines here.
#   3. Commit and push. Users on the tap pick up the new version on `brew update`.
class Forge < Formula
  desc "Local-first workflow engine for coding agents"
  homepage "https://github.com/ForgeAILab/forge"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-aarch64-macos.tar.gz"
      sha256 "7f3132b825d733440e3d091c08024afe2c85f4a7093eb8cf46f3e41916b52cb0"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-x86_64-macos.tar.gz"
      sha256 "76e4929ff59e0da6a3b7fdf79082f5d82551362821ff544b0b162dd90237e906"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-aarch64-linux.tar.gz"
      sha256 "35c95b2c9f2848c6aac355ce7d48e0a283033471440f69c67cbae493ae35d6d3"
    else
      url "https://github.com/ForgeAILab/forge/releases/download/v#{version}/forge-x86_64-linux.tar.gz"
      sha256 "3a366803f64e4e72dde6cd4c69ef508e00d2033b5859861632f7425e4e520f43"
    end
  end

  def install
    bin.install "forge"
    bin.install "forge-ctl"
    (share/"forge").install "web" if Dir.exist?("web")
  end

  def caveats
    <<~EOS
      Forge starts bound to 127.0.0.1:8080 and stores data under ~/.forge/.
      To launch with seeded demo data:
        forge --demo
      Then open http://localhost:8080
    EOS
  end

  test do
    assert_match "Usage: forge", shell_output("#{bin}/forge --help")
    assert_match "Forge CLI client", shell_output("#{bin}/forge-ctl --help")
  end
end
