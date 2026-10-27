# Project Goals — MuOS Ngage

## North Star
Deliver a first-class, controller-ready **Nokia N-Gage & Symbian OS (`EKA2L1`)** standalone emulator integration for **MustardOS (muOS)**, verified on the **Anbernic RG35XX H** and packaged both as an installable `.muxzip` archive and an upstream Pull Request to `MustardOS/internal`.

## Scope & Core Deliverables

### 1. Cloud Cross-Compilation Pipeline (Zero Local Linux Setup)
- Build `eka2l1_sdl2` from [`AveyondFly/EKA2L1`](https://github.com/AveyondFly/EKA2L1) targeting `aarch64-linux-gnu` (`Cortex-A53` / Allwinner H700) via **GitHub Actions**.
- Package required runtime assets (`resources/`, `scripts/`, `compat/`, `panic.json`, GLES shaders) alongside the binary.
- Automatically produce an installable `MuOS-Ngage.muxzip` artifact on every CI run.

### 2. MustardOS Launch Script (`ext-eka2l1.sh`)
- Strictly POSIX-compliant (`#!/bin/sh`, passing `ShellCheck`).
- Integrates with muOS helpers (`/opt/muos/script/var/display.sh`, `SETUP_SDL_ENVIRONMENT`, `SET_VAR "system" "foreground_process"`).
- **Zero-Friction Firmware Provisioning**: Automatically detects and installs Nokia N-Gage / S60 device firmware (`*.rpkg` + `*.rom` / `SYM.ROM`) from `/run/muos/storage/bios/eka2l1` on first run via `--installdevice`.
- **Smart Content Dispatch**:
  - `.sis` / `.sisx`: Installs the package into the persistent EKA2L1 `C:`/`E:` drive storage (`--install`) and launches the EKA2L1 grid launcher.
  - `.ngage` / Zip / Folder (N-Gage game card structure with `system/apps/...`): Mounts the game card via `--mount` and launches into the app or launcher.
  - `.cmd` / `.symbian`: Reads an app UID (`0x...`) or app name from the file and boots directly into the game via `--run`.

### 3. RG35XX H Controller Mapping (`eka2l1.gptk`)
- Uses `gptokeyb2` to translate RG35XX H hardware inputs to `eka2l1_sdl2` keyboard bindings:
  - **D-Pad**: Arrow Keys (Up / Down / Left / Right)
  - **A / B**: Enter (OK/Select) / Numpad `5` & `7` (primary N-Gage action buttons)
  - **X / Y**: Numpad `1` & `3` (secondary N-Gage action buttons)
  - **L1 / R1**: `F1` (Left Softkey) / `F2` (Right Softkey)
  - **Select / Start**: `F3` (Green Call Key) / `F4` (Red End Key)
  - **L2 / R2**: `R` (Screen Rotation + D-Pad remap) / `F5` (EKA2L1 OSD Menu)
  - **Right Analog / L3**: Numpad keys (`0, 2, 4, 6, 8, 9, *, #`) & `Backspace` (`C` Clear key)
  - **Menu + Start**: Cleanly terminates `eka2l1_sdl2` (`Escape` / kill hook)

### 4. Upstream Pull Requests
- **PR 1 (`MustardOS/internal`)**: Submit `script/launch/ext-eka2l1.sh`, `share/emulator/eka2l1/`, and `share/info/manifest/core.json` (`Nokia N-Gage` system entry).
- **PR 2 (`MustardOS/mustardos.github.io`)**: Submit system documentation and BIOS/firmware setup instructions using Australian English per MustardOS style guidelines.

## Success Criteria
1. GitHub Actions compiles `eka2l1_sdl2` (`aarch64`) and packages `MuOS-Ngage.muxzip` cleanly.
2. Installing `MuOS-Ngage.muxzip` via Archive Manager on the RG35XX H registers the `Nokia N-Gage` system in Core Assignment.
3. Launching an N-Gage game from muOS Explore Content boots with working GLESv2 video, ALSA audio, and full gamepad control, and exits cleanly back to muOS.
4. All shell scripts pass `shellcheck -s sh` with zero warnings.
