#!/bin/sh
set -eu

# This enables tapping, like tap-to-click, on laptops.
# The touchpad ID changes between reboots sometimes.
# So does the property ID for tapping.
#
# We need the property "Tapping Enabled".
# Available properties viewable with:
#       xinput list-props $TOUCHPAD_ID
#
# Requires:
#       xinput, libinput

TOUCHPAD_ID="$(xinput | awk '/Touchpad/ {split($6, a, "="); print a[2]}')"
#TAPPING_PROP_ID="$(xinput list-props "$TOUCHPAD_ID" | awk '/Tapping Enabled \(/ {split($4, a, "[()]"); print a[2]}')"
TAPPING_PROP_ID="$(xinput list-props "$TOUCHPAD_ID" | awk '/Tap Action \(/ {split($4, a, "[()]"); print a[2]}')"
PALM_DETECT_PROP="$(xinput list-props "$TOUCHPAD_ID" | awk '/Palm Detection \(/ {split($4, a, "[()]"); print a[2]}')"

printf 'Touchpad ID:\t\t%s\n' "$TOUCHPAD_ID"
printf 'Tapping Prop:\t\t%s\n' "$TAPPING_PROP_ID"
printf "Palm Detect Prop:\t%s\n" "$PALM_DETECT_PROP"

/usr/bin/xinput set-prop "$TOUCHPAD_ID" "$TAPPING_PROP_ID" 1 1 1 1 1 1
/usr/bin/xinput set-prop "$TOUCHPAD_ID" "$PALM_DETECT_PROP" 1

printf '\n...Tapping Enabled\n'

