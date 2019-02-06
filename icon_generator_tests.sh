#!/bin/bash

# Tests all use cases of ios_icon_generator.sh.  Will save each case in a different folder in the current directory.

usage() {
    echo Usage: icon_generator_tests.sh file_name.png
}

IMG=$1

if [ -z $IMG ]; then
	echo ERROR: Image file not supplied.
	usage
	exit 1
fi

echo "iOS app icons..."
DIR=ios_app
mkdir $DIR
./icon_generator.sh -i $IMG -p ios -t app -d $DIR/

echo "iOS toolbar icons..."
DIR=ios_toolbar
mkdir $DIR
./icon_generator.sh -i $IMG -p ios -t toolbar -d $DIR/

# Since colorized and trimmed icons apply to all types, only need to test them once.
echo "iOS toolbar icons, colorized..."
DIR=ios_toolbar_colorized
mkdir $DIR
./icon_generator.sh -i $IMG -p ios -t toolbar -d $DIR/ -c red

echo "iOS toolbar icons, whitespace removed..."
DIR=ios_toolbar_trimmed
mkdir $DIR
./icon_generator.sh -i $IMG -p ios -t toolbar -d $DIR/ -w

echo "iOS tabbar icons..."
DIR=ios_tabbar
mkdir $DIR
./icon_generator.sh -i $IMG -p ios -t tabbar -d $DIR/

echo "iOS tableviewcell icons..."
DIR=ios_tableviewcell
mkdir $DIR
./icon_generator.sh -i $IMG -p ios -t tableviewcell -d $DIR/

echo "iOS custom icons..."
DIR=ios_custom
mkdir $DIR
./icon_generator.sh -i $IMG -p ios -t custom -s 100 -d $DIR/

echo "Android action icons..."
DIR=android_action
mkdir $DIR
./icon_generator.sh -i $IMG -p android -t action -d $DIR/

echo "Android material/notificaion action icons..."
DIR=android_action_material
mkdir $DIR
./icon_generator.sh -i $IMG -p android -t action -d $DIR/ -m

echo "Android small icons..."
DIR=android_small
mkdir $DIR
./icon_generator.sh -i $IMG -p android -t small -d $DIR/

echo "Android custom icons..."
DIR=android_custom
mkdir $DIR
./icon_generator.sh -i $IMG -p android -t custom -s 100 -d $DIR/