## Mobile Icon Generator
A simple script to generate icon assets for Android and iOS.

## Supported icons
Most types of icons are supported.  Sizes are based on:
* [Icon Handbook](http://iconhandbook.co.uk/reference/chart/android/) for Android
* [Human Interface Guidelines](https://developer.apple.com/ios/human-interface-guidelines/graphics/custom-icons/) for iOS

### Android
* Action, dialog, and tab
* Notification
* Small context

### iOS
* Application icon
* Tabbar
* Toolbar

## How it works
The script uses [ImageMagick](https://www.imagemagick.org/script/index.php) CLI tool to take a given icon, scale, colorize, and create an asset for the desired platform.

For iOS, a `.imageset` package is created and saved to a given directory.

For Android, `drawable-xxxx` directories are created in the given directory if they don't already exist, and the generated icons are saved to these directories.

## Usage
Download the repository and place the icon in the extracted folder.  Run `./icon_generator.sh` for usage instructions.

Enjoy!
