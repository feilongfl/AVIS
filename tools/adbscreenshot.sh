#!/usr/bin/env fish

set tempLocal /tmp/adbscreenshot.png
adb exec-out screencap -p > $tempLocal
cp $tempLocal $argv
