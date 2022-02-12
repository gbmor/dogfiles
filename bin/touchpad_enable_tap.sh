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

/usr/bin/xinput set-prop "$TOUCHPAD_ID" 320 1
