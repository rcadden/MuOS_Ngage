#!/bin/sh
set -eu

# Deterministic packaging script to create MuOS-Ngage.muxzip for muOS Archive Manager
# Expects compiled eka2l1_sdl2 output directory at $1 (default: build-aarch64/bin)

BUILD_BIN_DIR="${1:-build-aarch64/bin}"
STAGE_DIR="dist/stage"
OUT_ZIP="dist/MuOS-Ngage.muxzip"

rm -rf "$STAGE_DIR" "$OUT_ZIP"
mkdir -p "$STAGE_DIR/opt/muos/script/launch"
mkdir -p "$STAGE_DIR/opt/muos/share/emulator/eka2l1/gptk"
mkdir -p "$STAGE_DIR/opt/muos/share/emulator/eka2l1/libs"
mkdir -p "$STAGE_DIR/opt/muos/share/task/EKA2L1 Setup"

# 1. Copy launch script and manifest patch
cp src/muos-internal/script/launch/ext-eka2l1.sh "$STAGE_DIR/opt/muos/script/launch/ext-eka2l1.sh"
chmod +x "$STAGE_DIR/opt/muos/script/launch/ext-eka2l1.sh"

cp src/muos-internal/share/emulator/eka2l1/gptk/eka2l1.gptk "$STAGE_DIR/opt/muos/share/emulator/eka2l1/gptk/eka2l1.gptk"
cp src/muos-internal/share/emulator/eka2l1/config.default.yml "$STAGE_DIR/opt/muos/share/emulator/eka2l1/config.default.yml"
cp src/muos-internal/share/info/manifest/core.patch.json "$STAGE_DIR/opt/muos/share/emulator/eka2l1/core.patch.json"
cp execution/register-eka2l1-core.sh "$STAGE_DIR/opt/muos/share/task/EKA2L1 Setup/Register Nokia N-Gage Core.sh"
chmod +x "$STAGE_DIR/opt/muos/share/task/EKA2L1 Setup/Register Nokia N-Gage Core.sh"

# 2. Copy compiled binary and runtime assets if present
if [ -d "$BUILD_BIN_DIR" ]; then
	cp -r "$BUILD_BIN_DIR/"* "$STAGE_DIR/opt/muos/share/emulator/eka2l1/"
	chmod +x "$STAGE_DIR/opt/muos/share/emulator/eka2l1/eka2l1_sdl2" 2>/dev/null || true
fi

# 3. Bundle into .muxzip
mkdir -p dist
(
	cd "$STAGE_DIR"
	zip -rq "../../$OUT_ZIP" opt
)

printf "Packaged %s successfully.\n" "$OUT_ZIP"
