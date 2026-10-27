#!/bin/sh

. /opt/muos/script/var/display.sh

NAME=$1
CORE=$2
FILE=${3%/}

(
	LOG_INFO "$0" 0 "Content Launch" "DETAIL"
	LOG_INFO "$0" 0 "NAME" "$NAME"
	LOG_INFO "$0" 0 "CORE" "$CORE"
	LOG_INFO "$0" 0 "FILE" "$FILE"
) &

EKA_BIN="eka2l1_sdl2"
EMU_DIR="$MUOS_SHARE_DIR/emulator/eka2l1"
SAVE_DIR="$MUOS_STORE_DIR/save/eka2l1"
BIOS_DIR="$MUOS_STORE_DIR/bios/eka2l1"

mkdir -p "$SAVE_DIR" "$BIOS_DIR"

HOME="$SAVE_DIR"
export HOME

LD_LIBRARY_PATH="$EMU_DIR/libs:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH

CUBEB_BACKEND="alsa"
export CUBEB_BACKEND

SETUP_SDL_ENVIRONMENT

SET_VAR "system" "foreground_process" "$EKA_BIN"

chmod +x "$EMU_DIR/$EKA_BIN"
cd "$EMU_DIR" || exit 1

# Seed default config.yml into persistent storage if absent, and point storage to $SAVE_DIR
if [ ! -f "$EMU_DIR/config.yml" ] && [ -f "$EMU_DIR/config.default.yml" ]; then
	cp "$EMU_DIR/config.default.yml" "$EMU_DIR/config.yml"
fi

if [ -f "$EMU_DIR/config.yml" ]; then
	sed -i "s|^storage:.*|storage: $SAVE_DIR|" "$EMU_DIR/config.yml"
fi

# Auto-provision device firmware (RPKG + ROM) from MUOS/bios/eka2l1 if no device is installed yet
if [ ! -d "$SAVE_DIR/drives/z" ] || [ -z "$(ls -A "$SAVE_DIR/drives/z" 2>/dev/null)" ]; then
	RPKG_FILE=$(find "$BIOS_DIR" -maxdepth 2 -type f -iname "*.rpkg" | head -n 1)
	ROM_FILE=$(find "$BIOS_DIR" -maxdepth 2 -type f \( -iname "*.rom" -o -iname "SYM.ROM" \) | head -n 1)
	if [ -n "$RPKG_FILE" ] && [ -n "$ROM_FILE" ]; then
		LOG_INFO "$0" 0 "EKA2L1" "Provisioning device firmware from $BIOS_DIR"
		"./$EKA_BIN" --installdevice "$RPKG_FILE" "$ROM_FILE"
	fi
fi

# Set up gptokeyb2 controller mapping (per-game override or default eka2l1.gptk)
GPTK_DIR="$EMU_DIR/gptk"
GAME_BN=$(basename "${FILE%.*}")
GPTK_SP="$GPTK_DIR/${GAME_BN}.gptk"
[ ! -f "$GPTK_SP" ] && GPTK_SP="$GPTK_DIR/eka2l1.gptk"

PM_DIR="$(GET_VAR "device" "storage/rom/mount")/MUOS/PortMaster"
LIB_IPOSE="libinterpose.aarch64.so"
if [ -d "$PM_DIR" ]; then
	ln -sf "$PM_DIR/$LIB_IPOSE" "/usr/lib/$LIB_IPOSE" >/dev/null 2>&1
	"$PM_DIR/gptokeyb2" "$EKA_BIN" -c "$GPTK_SP" &
	GPTK_PID=$!
fi

# Dispatch based on content file type
EXT=$(printf '%s' "${FILE##*.}" | tr '[:upper:]' '[:lower:]')

case "$EXT" in
	sis | sisx)
		# Install SIS package into persistent storage first, then open launcher
		"./$EKA_BIN" --install "$FILE"
		"./$EKA_BIN"
		;;
	cmd | symbian | ngage-uid)
		# Text shortcut containing an App UID (e.g. 0x101f95bc) or App Name
		APP_TARGET=$(sed -n '1p' "$FILE" | tr -d '\r\n')
		if [ -n "$APP_TARGET" ]; then
			"./$EKA_BIN" --run "$APP_TARGET"
		else
			"./$EKA_BIN"
		fi
		;;
	zip | ngage)
		# Mount zip/N-Gage archive as Game Card on E: and open launcher
		"./$EKA_BIN" --mount "$FILE"
		;;
	*)
		if [ -d "$FILE" ]; then
			"./$EKA_BIN" --mount "$FILE"
		else
			# Look for an N-Gage game folder alongside a stub file
			GAME_DIR="$(dirname "$FILE")/$GAME_BN"
			if [ -d "$GAME_DIR" ]; then
				"./$EKA_BIN" --mount "$GAME_DIR"
			else
				"./$EKA_BIN"
			fi
		fi
		;;
esac

if [ -n "${GPTK_PID:-}" ]; then
	kill -9 "$GPTK_PID" >/dev/null 2>&1
fi
