# EKA2L1 (Nokia N-Gage / Symbian OS) for MustardOS

Standalone `aarch64` OpenGL ES 2.0 + SDL2 emulator for Nokia N-Gage and Symbian OS devices, based on [`AveyondFly/EKA2L1`](https://github.com/AveyondFly/EKA2L1).

## BIOS / Firmware Setup
Place your dumped Nokia N-Gage (NEM-4 / `SYM.ROM` + `.rpkg`) firmware files into:
```text
MUOS/bios/eka2l1/
├── SYM.ROM
└── NEM-4.rpkg
```
On first launch, `ext-eka2l1.sh` automatically provisions the firmware into persistent storage (`MUOS/save/eka2l1/`).

## Supported Content Formats (`ROMS/N-Gage/`)
- **`.sis` / `.sisx`**: Automatically installs the Symbian package on launch and opens the EKA2L1 App Launcher.
- **`.zip` / `.ngage` / Game Folder**: Mounts the N-Gage MMC Game Card (`System/Apps/...`) onto `E:` and opens the launcher.
- **`.cmd` / `.symbian`**: Direct launch shortcut containing an App UID (e.g., `0x101f95bc`) or Application Name on the first line.

## Default Controls (RG35XX H / `eka2l1.gptk`)
| Handheld Input | Symbian / N-Gage Key |
| :--- | :--- |
| **D-Pad / Left Stick** | Up / Down / Left / Right |
| **A** | Center Select / OK (`Enter`) |
| **B / X** | Numpad `5` (Primary Action) / Numpad `7` (Secondary Action) |
| **Y** | Clear / Backspace (`C`) |
| **L1 / R1** | Left Softkey (`F1`) / Right Softkey (`F2`) |
| **Select / Start** | Green Call (`F3`) / Red End (`F4`) |
| **L2 / R2** | Rotate Screen 90° (`R`) / EKA2L1 OSD Menu (`F5`) |
| **Right Stick** | Up=`1`, Down=`3`, Left=`*`, Right=`#` |
| **L3 / R3** | Numpad `0` / Numpad `9` |
