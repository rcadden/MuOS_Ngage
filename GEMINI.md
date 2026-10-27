# MuOS Ngage — Project Configuration

## Project Name & North Star
**MuOS Ngage**: Port `AveyondFly/EKA2L1` (SDL2/GLESv2 `aarch64` Symbian OS & Nokia N-Gage emulator) into **MustardOS (muOS)** as a native standalone external emulator, delivering both an immediately installable `.muxzip` archive for RG35XX H testing and upstream Pull Requests to `MustardOS/internal` and `MustardOS/mustardos.github.io`.

## Status
- **Phase**: Initialized (Sprint 1: Foundation & CI Build Pipeline)
- **Active Branch**: `dev`

## Tech Stack
- **Emulator Core**: [`AveyondFly/EKA2L1`](https://github.com/AveyondFly/EKA2L1) (`eka2l1_sdl2` C++17, SDL2, SDL2_ttf, OpenGL ES 2.0, ALSA via Cubeb)
- **Target OS**: MustardOS (muOS) — BusyBox POSIX `/bin/sh` runtime
- **Target Hardware**: Anbernic **RG35XX H** (`Allwinner H700` quad-core Cortex-A53 `aarch64`, Mali-G31 MP2 GLESv2, 640x480 4:3 display, dual analog + L1/L2/R1/R2)
- **Input Bridge**: `gptokeyb2` (`eka2l1.gptk`) mapping RG35XX H controls to Symbian/N-Gage keypad & EKA2L1 hotkeys
- **Build & CI Pipeline**: GitHub Actions (`ubuntu-22.04` / `aarch64-linux-gnu-g++` multiarch cross-compilation + `ShellCheck` POSIX validation + automated `.muxzip` artifact packaging)
- **Cloudflare Model**: None required (Firmware package & GitHub Releases / Upstream PRs)

## Active Integrations
- **GitHub Actions CI**: Cloud cross-compilation for `aarch64` (zero local WSL2/Docker requirement) and `.muxzip` release packaging
- **Upstream Target 1**: [`MustardOS/internal`](https://github.com/MustardOS/internal) (`script/launch/ext-eka2l1.sh`, `share/emulator/eka2l1/`, `share/info/manifest/core.json`)
- **Upstream Target 2**: [`MustardOS/mustardos.github.io`](https://github.com/MustardOS/mustardos.github.io) (System documentation & BIOS/ROM reference)

## Environment & Credentials
- **Local Testing Device**: Anbernic RG35XX H running MustardOS (muOS)
- **Device Board Identifier**: `rg35xx-h` (Allwinner H700 `aarch64`)
- **Key muOS Device Paths**:
  - Launch Script: `/opt/muos/script/launch/ext-eka2l1.sh`
  - Emulator Directory: `/opt/muos/share/emulator/eka2l1`
  - System Manifest: `/opt/muos/share/info/manifest/core.json` (or user override `/run/muos/storage/info/manifest/core.json`)
  - Persistent Saves / Storage: `/run/muos/storage/save/eka2l1`
  - BIOS / Firmware Directory: `/run/muos/storage/bios/eka2l1` (holds `SYM.ROM` and `.rpkg` files)
  - ROMs Directory: `/mnt/mmc/ROMS/N-Gage` or `/mnt/sdcard/ROMS/N-Gage`

## Coding & Contribution Standards (MustardOS Upstream Rules)
1. **POSIX Shell Strictness**: All scripts in `src/muos-internal/script/` MUST start with `#!/bin/sh` and avoid bash-only features (`[[`, arrays, `local` where non-standard). Must pass `shellcheck -s sh`.
2. **Australian English**: Upstream documentation in `mustardos.github.io` uses Australian English (e.g., `catalogue`, `colour`, `licence`) and refers to the project as **MustardOS** and maintainers as the **crew**.
3. **Clean Teardown**: Every resource modified on launch (`gptokeyb2`, `foreground_process`, SDL environment) must be cleanly restored on exit.

## Lessons Learned
- *2026-10-27 (Architecture)*: `MustardOS/extra` is exclusively for Libretro `.so` cores built via MURCB. Standalone external emulators live in `MustardOS/internal` under `share/emulator/<name>` with a launcher in `script/launch/ext-<name>.sh` and a system entry in `share/info/manifest/core.json`.
- *2026-10-27 (Manifest Override)*: A user-storage `MUOS/info/manifest/core.json` completely replaces `/opt/muos/share/info/manifest/core.json`. When building `.muxzip` packages for testing, patch the existing `core.json` via `jq` rather than overwriting it with a stale snapshot.
