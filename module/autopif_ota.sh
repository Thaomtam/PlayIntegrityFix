#!/bin/sh

PATH=/data/adb/ap/bin:/data/adb/ksu/bin:/data/adb/magisk:/data/data/com.termux/files/usr/bin:$PATH
MODDIR=/data/adb/modules/playintegrityfix

. $MODDIR/common_func.sh

# lets try to use tmpfs for processing
TEMPDIR="$MODDIR/temp" #fallback
[ -w /sbin ] && TEMPDIR="/sbin/playintegrityfix"
[ -w /debug_ramdisk ] && TEMPDIR="/debug_ramdisk/playintegrityfix"
[ -w /dev ] && TEMPDIR="/dev/playintegrityfix"
mkdir -p "$TEMPDIR"
cd "$TEMPDIR"

# current hash
curhash="$(busybox crc32 $MODDIR/autopif.sh 2>/dev/null || echo 000000 )"

# check
download "https://raw.githubusercontent.com/KOWX712/PlayIntegrityFix/inject_manual/module/autopif.sh" "$TEMPDIR/temp_autopif.sh"

if [ ! "$(busybox crc32 $TEMPDIR/temp_autopif.sh)" = "$curhash" ]; then
    cat "$TEMPDIR/temp_autopif.sh" > "$MODDIR/autopif.sh"
    echo "[+] autopif has been updated"
fi

rm -rf "$TEMPDIR"

# EOF
