#!/usr/bin/env bash

pgrep -f signal-desktop >/dev/null || (signal-desktop >/dev/null 2>&1 &)
pgrep -f bitwarden >/dev/null || (bitwarden >/dev/null 2>&1 &)
pgrep -f easyeffects >/dev/null || (easyeffects >/dev/null 2>&1 &)
pgrep -f librepods >/dev/null || (librepods >/dev/null 2>&1 &)
pkill nm-applet
