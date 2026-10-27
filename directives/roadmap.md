# Roadmap — MuOS Ngage

## Sprint 1: Foundation & Cloud Build Pipeline
- [x] **Architectural research on `AveyondFly/EKA2L1` and `MustardOS/internal`**
- [x] **Initialize `MuOS_Ngage` repository, starter launch scripts, and GitHub Actions CI workflow**
- [ ] **Connect repository to GitHub and verify first cloud `aarch64` build of `eka2l1_sdl2`**
- [ ] **Download and inspect the generated `MuOS-Ngage.muxzip` build artifact**

## Sprint 2: RG35XX H Hardware Verification & Tuning
- [ ] **Install `MuOS-Ngage.muxzip` on the RG35XX H via muOS Archive Manager**
- [ ] **Verify automatic firmware provisioning (`SYM.ROM` + `.rpkg`) from `MUOS/bios/eka2l1/`**
- [ ] **Verify N-Gage game card mounting (`--mount`), `.sis` installation (`--install`), and direct UID launch (`--run`)**
- [ ] **Tune `eka2l1.gptk` controller layout and 640x480 display scaling on RG35XX H**

## Sprint 3: Upstream MustardOS Contribution
- [ ] **Fork `MustardOS/internal` and apply `ext-eka2l1.sh`, `share/emulator/eka2l1/`, and `core.json` changes**
- [ ] **Run upstream CI checks (`ShellCheck` POSIX validation and JSON schema check)**
- [ ] **Open Pull Request to `MustardOS/internal` and documentation PR to `MustardOS/mustardos.github.io`**

---

## Future Explorations
- Native `SDL_GameController` button binding directly inside `AveyondFly/EKA2L1` (`src/emu/sdl2/src/main.cpp`) so `gptokeyb2` becomes optional.
- Per-game `.gptk` profiles for N-Gage titles with unique keypad layouts (e.g., *Pathway to Glory*, *Tony Hawk's Pro Skater*, *The Elder Scrolls Travels: Shadowkey*).
- MuOS Task Toolkit script (`muxtask`) to batch-install `.sis` files or generate `.cmd` UID shortcuts automatically.
