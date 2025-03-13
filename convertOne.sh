#!/bin/bash

echo "Converting $1"
python wrap.py "$1" "convertedApps/$(basename "$1")";
#xcrun simctl install "your simulator device udid" "convertedApps/$(basename "$1")";
