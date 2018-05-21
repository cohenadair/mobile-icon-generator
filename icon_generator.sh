#!/bin/bash

usage() {
    echo
    echo Usage: icon_generator.sh -i image file -p platform -t icon type [-d directory] [-c color] [-w] [-m]
    echo
    echo "  -i The original image file."
    echo "  -p The icon's platform. Valid options:"
    echo "     ios"
    echo "     android"
    echo "  -t Most iOS and Anroid icons are supported. Valid options:"
    echo "     toolbar (iOS) (1x = 22x22)"
    echo "     tabbar (iOS) (1x = 25x25)"
    echo "     tableviewcell (iOS) (1x = 25x25)"
    echo "     app (iOS)"
    echo "     action (Android)"
    echo "     notification (Android)"
    echo "     small (Android)"
    echo "     custom (Android and iOS)"
    echo "  -s Optional. The size of the new icon; used for -t == custom"
    echo "     -s 100"
    echo "  -d The directory the images will be saved to. Default is the current directory."
    echo "     On iOS, icons, along with a Contents.json file, are saved in a .imageset file."
    echo "     On Android, a new directory for each density is created, if it doesn't already exist."
    echo "  -c Optional. A color used to mask the original image. Example: blue, \"#929292\"." 
    echo "     Default keeps the original color." 
    echo "     This flag does not apply to -type app."
    echo "  -w Optional. Removes whitespace around the original image."
    echo "     Default keeps the original whitespace." 
    echo "     This flag does not apply to -type app."
    echo "  -m Optional. Enables Google Material Design icon sizes (slightly smaller than normal)."
    echo "     This flag only applies to Android."
    echo
    echo ./icon_generator.sh -i ic_trash.png -p ios -t toolbar -d ~/icons/ -c red
    echo
    echo This script requires ImageMagick for image manipulation.
    echo https://www.imagemagick.org/script/index.php
    echo 
}

TRIM=0
COLORIZE=0
MATERIAL=0
while getopts "i:p:t:s:d:c:wm" OPTION
do
    case $OPTION in
    i)
        IMG=$OPTARG
        ;;
    p)
        PLATFORM=$OPTARG
        ;;
    t)
        TYPE=$OPTARG
        ;;
    s) 
        SIZE=$OPTARG
        ;;
    d)
        DIR=$OPTARG
        ;;
    c)
        COLORIZE=1
        COLOR=$OPTARG
        ;;
    w)
        TRIM=1
        ;;
    m)
        MATERIAL=1
        ;;
    esac
done

# Argument validation.

if [ -z $IMG ]; then
    echo ERROR: Image file missing.
    usage
    exit 1
fi

if [ -z $PLATFORM ]; then
    echo ERROR: Platform missing.
    usage
    exit 1
fi

if [ -z $TYPE ]; then
    echo ERROR: Icon type not supplied.
    usage
    exit 1
fi

if [ $TYPE = custom ] && [ -z $SIZE ]; then
    echo ERROR: Size not specified for type 'custom'.
    usage
    exit 1
fi

# File extension of the input image.
EXT=.${IMG##*.}

# File name of the input image, sans extension.
FILE_NAME=${IMG%.*}
ORIGINAL_FILE_NAME=$FILE_NAME

# Creates a given directory if it doesn't already exist.
makeDir() {
    if [ ! -d "$1" ]; then
        mkdir $1
    fi
}

# iOS app icon
if [ $PLATFORM = ios -a $TYPE = app ]; then
    # Create .imageset directory.
    DIR=$DIR$ORIGINAL_FILE_NAME".appiconset"
    makeDir $DIR

    FILE_20x20=$FILE_NAME"_20"$EXT
    FILE_29x29=$FILE_NAME"_29"$EXT
    FILE_40x40=$FILE_NAME"_40"$EXT
    FILE_40x40_1=$FILE_NAME"_40-1"$EXT
    FILE_40x40_2=$FILE_NAME"_40-2"$EXT
    FILE_60x60=$FILE_NAME"_60"$EXT
    FILE_58x58=$FILE_NAME"_58"$EXT
    FILE_58x58_1=$FILE_NAME"_58-1"$EXT
    FILE_76x76=$FILE_NAME"_76"$EXT
    FILE_87x87=$FILE_NAME"_87"$EXT
    FILE_80x80=$FILE_NAME"_80"$EXT
    FILE_80x80_1=$FILE_NAME"_80-1"$EXT
    FILE_120x120=$FILE_NAME"_120"$EXT
    FILE_120x120_1=$FILE_NAME"_120-1"$EXT
    FILE_152x152=$FILE_NAME"_152"$EXT
    FILE_167x167=$FILE_NAME"_167"$EXT
    FILE_180x180=$FILE_NAME"_180"$EXT
    FILE_1024x1024=$FILE_NAME"_1024"$EXT

    convert $IMG -resize 20x20 $DIR/$FILE_20x20
    convert $IMG -resize 29x29 $DIR/$FILE_29x29
    convert $IMG -resize 40x40 $DIR/$FILE_40x40
    convert $IMG -resize 40x40 $DIR/$FILE_40x40_1
    convert $IMG -resize 40x40 $DIR/$FILE_40x40_2
    convert $IMG -resize 60x60 $DIR/$FILE_60x60
    convert $IMG -resize 58x58 $DIR/$FILE_58x58
    convert $IMG -resize 58x58 $DIR/$FILE_58x58_1
    convert $IMG -resize 76x76 $DIR/$FILE_76x76
    convert $IMG -resize 87x87 $DIR/$FILE_87x87
    convert $IMG -resize 80x80 $DIR/$FILE_80x80
    convert $IMG -resize 80x80 $DIR/$FILE_80x80_1
    convert $IMG -resize 120x120 $DIR/$FILE_120x120
    convert $IMG -resize 120x120 $DIR/$FILE_120x120_1
    convert $IMG -resize 152x152 $DIR/$FILE_152x152
    convert $IMG -resize 167x167 $DIR/$FILE_167x167
    convert $IMG -resize 180x180 $DIR/$FILE_180x180
    convert $IMG -resize 1024x1024 $DIR/$FILE_1024x1024

    # Create Contents.json file.
    cat << EOF > $DIR/Contents.json
{
  "images" : [
    {
      "size" : "20x20",
      "idiom" : "iphone",
      "filename" : "$FILE_40x40_1",
      "scale" : "2x"
    },
    {
      "size" : "20x20",
      "idiom" : "iphone",
      "filename" : "$FILE_60x60",
      "scale" : "3x"
    },
    {
      "size" : "29x29",
      "idiom" : "iphone",
      "filename" : "$FILE_58x58",
      "scale" : "2x"
    },
    {
      "size" : "29x29",
      "idiom" : "iphone",
      "filename" : "$FILE_87x87",
      "scale" : "3x"
    },
    {
      "size" : "40x40",
      "idiom" : "iphone",
      "filename" : "$FILE_80x80",
      "scale" : "2x"
    },
    {
      "size" : "40x40",
      "idiom" : "iphone",
      "filename" : "$FILE_120x120",
      "scale" : "3x"
    },
    {
      "size" : "60x60",
      "idiom" : "iphone",
      "filename" : "$FILE_120x120_1",
      "scale" : "2x"
    },
    {
      "size" : "60x60",
      "idiom" : "iphone",
      "filename" : "$FILE_180x180",
      "scale" : "3x"
    },
    {
      "size" : "20x20",
      "idiom" : "ipad",
      "filename" : "$FILE_20x20",
      "scale" : "1x"
    },
    {
      "size" : "20x20",
      "idiom" : "ipad",
      "filename" : "$FILE_40x40",
      "scale" : "2x"
    },
    {
      "size" : "29x29",
      "idiom" : "ipad",
      "filename" : "$FILE_29x29",
      "scale" : "1x"
    },
    {
      "size" : "29x29",
      "idiom" : "ipad",
      "filename" : "$FILE_58x58_1",
      "scale" : "2x"
    },
    {
      "size" : "40x40",
      "idiom" : "ipad",
      "filename" : "$FILE_40x40_2",
      "scale" : "1x"
    },
    {
      "size" : "40x40",
      "idiom" : "ipad",
      "filename" : "$FILE_80x80_1",
      "scale" : "2x"
    },
    {
      "size" : "76x76",
      "idiom" : "ipad",
      "filename" : "$FILE_76x76",
      "scale" : "1x"
    },
    {
      "size" : "76x76",
      "idiom" : "ipad",
      "filename" : "$FILE_152x152",
      "scale" : "2x"
    },
    {
      "size" : "83.5x83.5",
      "idiom" : "ipad",
      "filename" : "$FILE_167x167",
      "scale" : "2x"
    },
    {
      "size" : "1024x1024",
      "idiom" : "ios-marketing",
      "filename" : "$FILE_1024x1024",
      "scale" : "1x"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "ios_icon_set"
  }
} 
EOF

    exit 1
fi

# System icons

# Create a colorized copy of the original file, if needed.
if [ $COLORIZE -ne 0 ]; then
    FILE_NAME_COLORIZED=$FILE_NAME"_colorized"
    convert $IMG -alpha off -fill $COLOR -colorize 100% -alpha on $FILE_NAME_COLORIZED$EXT
    FILE_NAME=$FILE_NAME_COLORIZED
fi

# Trim whitespace if needed, otherwise copy the file.
FILE_COPY=$FILE_NAME"_copy"$EXT
FILE=$FILE_NAME$EXT
if [ $TRIM -ne 0 ]; then
    convert $FILE -trim $FILE_COPY
else
    cp $FILE $FILE_COPY
fi

MDPI=$DIR"drawable-mdpi"
HDPI=$DIR"drawable-hdpi"
XHDPI=$DIR"drawable-xhdpi"
XXHDPI=$DIR"drawable-xxhdpi"
XXXHDPI=$DIR"drawable-xxxhdpi"

gen_android() {
    convert $FILE_COPY -resize $1 $MDPI/$IMG
    convert $FILE_COPY -resize $2 $HDPI/$IMG
    convert $FILE_COPY -resize $3 $XHDPI/$IMG
    convert $FILE_COPY -resize $4 $XXHDPI/$IMG
    convert $FILE_COPY -resize $5 $XXXHDPI/$IMG
}

handle_android() {
    makeDir $MDPI
    makeDir $HDPI
    makeDir $XHDPI
    makeDir $XXHDPI
    makeDir $XXXHDPI

    # Material Action, Notification
    if [ $TYPE = action -a $MATERIAL -ne 0 -o $TYPE = notification ]; then
        gen_android 24x24 36x36 48x48 72x72 96x96
    fi

    # Normal Action
    if [ $TYPE = action -a $MATERIAL = 0 ]; then
        gen_android 32x32 48x48 64x64 96x96 128x128
    fi

    # Small
    if [ $TYPE = small ]; then
        gen_android 16x16 24x24 32x32 48x48 64x64
    fi
}

gen_ios_icon() {
    FILE_1X=$ORIGINAL_FILE_NAME"_1x"$EXT
    FILE_2X=$ORIGINAL_FILE_NAME"_2x"$EXT
    FILE_3X=$ORIGINAL_FILE_NAME"_3x"$EXT

    convert $FILE_COPY -resize $2 $1/$FILE_1X
    convert $FILE_COPY -resize $3 $1/$FILE_2X
    convert $FILE_COPY -resize $4 $1/$FILE_3X
}

handle_ios() {
    # Create .imageset directory.
    DIR=$DIR$ORIGINAL_FILE_NAME".imageset"
    makeDir $DIR

    # TabBar
    if [ $TYPE = tabbar ]; then
        gen_ios_icon $DIR 25x25 50x50 75x75
    fi

    # Toolbar
    if [ $TYPE = toolbar ]; then
        gen_ios_icon $DIR 22x22 44x44 66x66
    fi

    # UITableViewCell
    if [ $TYPE = tableviewcell ]; then
        gen_ios_icon $DIR 25x25 50x50 75x75
    fi

    # Custom
    if [ $TYPE = custom ]; then
        gen_ios_icon $DIR $SIZEx$SIZE `expr $SIZE \\* 2`x`expr $SIZE \\* 2` `expr $SIZE \\* 3`x`expr $SIZE \\* 3`
    fi

    # Create Contents.json file.
    cat << EOF > $DIR/Contents.json
{
  "images" : [
    {
      "idiom" : "universal",
      "filename" : "$FILE_1X",
      "scale" : "1x"
    },
    {
      "idiom" : "universal",
      "filename" : "$FILE_2X",
      "scale" : "2x"
    },
    {
      "idiom" : "universal",
      "filename" : "$FILE_3X",
      "scale" : "3x"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "ios_icon_set"
  }
} 
EOF
}

if [ $PLATFORM = android ]; then
    handle_android
fi

if [ $PLATFORM = ios ]; then
    handle_ios
fi

# Delete temporary files
rm $FILE_COPY
if [ $COLORIZE -ne 0 ]; then
    rm $FILE_NAME_COLORIZED$EXT
fi