#!/bin/sh
set -eu

# This enables tapping, like tap-to-click, on the Thinkpad T14s Gen2 AMD.
# The touchpad ID changes between reboots sometimes.
#
# We need property 318, "Tapping Enabled".
# Available properties viewable with:
#       xinput list-props $TOUCHPAD_ID
#
# Requires:
#       xinput, libinput

TOUCHPAD_ID="$(xinput | grep Touchpad | awk '{print $6}' | cut -d'=' -f2)"
TAPPING_PROP_ID="$(xinput list-props 14 | grep 'Tapping Enabled (' | cut -d'(' -f2 | cut -d')' -f1)"

printf 'Touchpad ID:\t%s\n' "$TOUCHPAD_ID"
printf 'Tapping Prop:\t%s\n' "$TAPPING_PROP_ID"

/usr/bin/xinput set-prop "$TOUCHPAD_ID" "$TAPPING_PROP_ID" 1

printf '\n...Tapping Enabled\n'
