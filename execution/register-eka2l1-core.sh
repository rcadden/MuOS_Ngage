#!/bin/sh
# Task Name: Register EKA2L1 (Nokia N-Gage) Core
# Injects the Nokia N-Gage external core definition into core.json safely via jq

. /opt/muos/script/var/ui.sh

SYS_MANIFEST="/opt/muos/share/info/manifest/core.json"
USR_MANIFEST="/run/muos/storage/info/manifest/core.json"
PATCH_FILE="/opt/muos/share/emulator/eka2l1/core.patch.json"

if [ ! -f "$PATCH_FILE" ]; then
	echo "Missing patch file: $PATCH_FILE" >&2
	exit 1
fi

# Patch system core.json in-place
if [ -f "$SYS_MANIFEST" ]; then
	jq -s '.[0] * .[1]' "$SYS_MANIFEST" "$PATCH_FILE" > "${SYS_MANIFEST}.tmp" && mv "${SYS_MANIFEST}.tmp" "$SYS_MANIFEST"
fi

# If user has a custom core.json on storage, patch that too so it isn't masked
if [ -f "$USR_MANIFEST" ]; then
	jq -s '.[0] * .[1]' "$USR_MANIFEST" "$PATCH_FILE" > "${USR_MANIFEST}.tmp" && mv "${USR_MANIFEST}.tmp" "$USR_MANIFEST"
fi

/opt/muos/script/system/assign.sh >/dev/null 2>&1
/opt/muos/script/system/catalogue.sh >/dev/null 2>&1
sync

exit 0
