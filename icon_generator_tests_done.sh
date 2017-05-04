#!/bin/bash

# Should be run after running icon_set_tests.sh and checking that the icons were genereated correctly. This script
# removes all test directories.

rm -rf ios_app
rm -rf ios_tabbar
rm -rf ios_toolbar
rm -rf ios_toolbar_colorized
rm -rf ios_toolbar_trimmed
rm -rf android_action
rm -rf android_action_material
rm -rf android_small