#!/bin/sh
set -e

if ! pgrep yubikey-touch-detector; then
    yubikey-touch-detector &
fi

if ! pgrep yubikey-push-the-button; then
    yubikey-push-the-button &
fi
