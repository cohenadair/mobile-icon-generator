## Mobile Icon Generator
A simple script to generate icon assets for Android and iOS.

## Features
* Most Android and iOS icon sizes
* Whitespace trimming
* Changing the original icon color
* Material and standard icon sizes for Android
* Optionally save generated icons directly in your project's asset folder

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
* Watch app icon
* Tabbar
* Toolbar
* `UITableViewCell` image view

### Custom
* Using `-t custom` and `-s <size>` flags, you can generate custom sizes for iOS.

## How it works
The script uses [ImageMagick](https://www.imagemagick.org/script/index.php) CLI tool to take a given icon, scale, colorize, and create an asset for the desired platform.

For iOS, a `.imageset` or `.appiconset` package is created and saved to a given directory.

For Android, `drawable-xxxx` directories are created in the given directory if they don't already exist, and the generated icons are saved to these directories.

## Usage
Download the repository and place the icon in the extracted folder.  Run `./icon_generator.sh` for usage instructions.

### Example
The following command will create an `ic_test.imageset` asset in my iOS project directory, and will include 1x, 2x, and 3x images, as well as the Xcode asset file, `Contents.json`.

`./icon_generator.sh -i ic_test.png -p ios -t tabbar -d ~/Workspace/my-project/MyProject/Assets.xcassets/`

Enjoy!
