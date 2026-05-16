# ForgeAILab Homebrew tap

Homebrew formulas for [Forge](https://github.com/ForgeAILab/forge) — the
local-first workflow engine for coding agents.

## Install

```bash
brew install forgeailab/tap/forge
```

That command implicitly taps this repository (`brew tap forgeailab/tap`) and
installs the latest published version of the `forge` formula. Subsequent
upgrades come through `brew upgrade forge` after `brew update`.

To install a specific version, point at a commit or tag of this tap.

## What you get

The formula installs two binaries plus the built web UI:

| Binary | Purpose |
|---|---|
| `forge` | The local server (binds `127.0.0.1:8080`, stores data under `~/.forge/`) |
| `forge-ctl` | CLI client for the REST API |

The web UI assets land under `$(brew --prefix)/share/forge/web/dist`. The
server resolves them automatically; no env var setup needed.

## Updating the formula after a Forge release

1. Bump `version` in `Formula/forge.rb` to the new tag (no leading `v`).
2. From this repo root, run:
   ```bash
   ./scripts/update-checksums.sh <version>
   ```
   The script pulls `SHA256SUMS` from the corresponding GitHub Release and
   rewrites the four `sha256 "REPLACE_WITH_..."` lines in the formula.
3. `brew audit --strict --online forgeailab/tap/forge` locally.
4. Commit, push, and the new version is live for users on `brew update`.

## Why a tap, not `homebrew-core`?

Submitting to `homebrew-core` requires meeting their notability bar
(typically 30-day-old project, 75+ GitHub stars, and stable releases). A
dedicated tap is the right place for a v0.1.x public beta — once Forge has
adoption and a stable release cadence, the formula can be promoted upstream
and this tap retired.

## License

[MIT](LICENSE) — formula files only. Forge itself is also MIT licensed; see
[ForgeAILab/forge](https://github.com/ForgeAILab/forge/blob/main/LICENSE).
