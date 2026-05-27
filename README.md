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

Forge release automation dispatches the `Update Forge formula` workflow when a
stable tag is published. To run the same update manually:

1. From this repo root, run:
   ```bash
   ./scripts/update-checksums.sh <version>
   ```
   The script pulls `SHA256SUMS` from the corresponding GitHub Release, updates
   the formula release URLs, and rewrites the four platform checksums.
2. `brew audit --strict --online forgeailab/tap/forge` locally after tapping
   this checkout.
3. Commit, push, and the new version is live for users on `brew update`.

The automated cross-repository dispatch expects the Forge source repository to
have a `HOMEBREW_TAP_TOKEN` secret that can create a `repository_dispatch` event
on `ForgeAILab/homebrew-tap`.

## Why a tap, not `homebrew-core`?

Submitting to `homebrew-core` requires meeting their notability bar
(typically 30-day-old project, 75+ GitHub stars, and stable releases). A
dedicated tap is the right place for a v0.1.x public beta — once Forge has
adoption and a stable release cadence, the formula can be promoted upstream
and this tap retired.

## License

[MIT](LICENSE) — formula files only. Forge itself is also MIT licensed; see
[ForgeAILab/forge](https://github.com/ForgeAILab/forge/blob/main/LICENSE).
