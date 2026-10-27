# MuOS Ngage

Port and upstream integration of [`AveyondFly/EKA2L1`](https://github.com/AveyondFly/EKA2L1) (Symbian OS & Nokia N-Gage `aarch64` SDL2/GLESv2 emulator) for **MustardOS (muOS)**, targeted and tested on the **Anbernic RG35XX H**.

---

## Architecture & Repository Layout

```text
MuOS_Ngage/
├── .github/workflows/
│   └── build-muos-ngage.yml          # Cloud cross-compilation (aarch64) + ShellCheck + .muxzip packaging
├── directives/
│   ├── project_goals.md              # North Star, scope, and success criteria
│   └── roadmap.md                    # Phased sprint roadmap
├── execution/
│   ├── toolchain-aarch64-muos.cmake  # CMake cross-compilation toolchain for Cortex-A53 (H700)
│   ├── register-eka2l1-core.sh       # Task Toolkit script to patch core.json in-place via jq
│   └── package-muxzip.sh             # Packages dist/MuOS-Ngage.muxzip for muOS Archive Manager
└── src/muos-internal/                # Exact directory mirror of MustardOS/internal for upstream PRs
    ├── script/launch/
    │   └── ext-eka2l1.sh             # POSIX launch script (firmware provisioning, gptokeyb2, content dispatch)
    └── share/
        ├── emulator/eka2l1/
        │   ├── gptk/eka2l1.gptk      # RG35XX H controller-to-N-Gage keypad mapping
        │   ├── config.default.yml    # Default EKA2L1 configuration
        │   └── README.md             # Emulator usage & BIOS documentation
        └── info/manifest/
            └── core.patch.json       # Nokia N-Gage system definition for core.json
```

---

## Testing on RG35XX H (via `.muxzip`)

1. Download the `MuOS-Ngage-aarch64-muxzip` artifact from GitHub Actions and extract `MuOS-Ngage.muxzip`.
2. Copy `MuOS-Ngage.muxzip` to `/ARCHIVE/` on your RG35XX H SD card.
3. Place your N-Gage firmware files (`SYM.ROM` and `.rpkg`) in `MUOS/bios/eka2l1/`.
4. On the RG35XX H, open **Applications → Archive Manager** and install `MuOS-Ngage`.
5. Open **Applications → Task Toolkit → EKA2L1 Setup → Register Nokia N-Gage Core** to add the `Nokia N-Gage` system to `core.json` without overwriting existing systems.
6. Place games in `ROMS/N-Gage/` and launch via **Explore Content**.
