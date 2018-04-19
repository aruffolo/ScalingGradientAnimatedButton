# ScalingGradientAnimatedButton

[![Version](https://img.shields.io/cocoapods/v/ScalingGradientAnimatedButton.svg?style=flat)](http://cocoapods.org/pods/ScalingGradientAnimatedButton)
[![License](https://img.shields.io/cocoapods/l/ScalingGradientAnimatedButton.svg?style=flat)](http://cocoapods.org/pods/ScalingGradientAnimatedButton)
[![Platform](https://img.shields.io/cocoapods/p/ScalingGradientAnimatedButton.svg?style=flat)](http://cocoapods.org/pods/ScalingGradientAnimatedButton)

## Overview

ScalingGradientAnimatedButton is a subclass of UIView, written is Swift, that encloses a gradient and scale animation in a view.

![](ButtonScreen.PNG?raw=true "Button Screenshoot in 'A Complex Calc")

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 8
* Swift 4.0

## Installation

ScalingGradientAnimatedButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ScalingGradientAnimatedButton'
```
## Usage

```Swift

import ScalingGradientAnimatedButton

/// then inside the viewDidLoad or any view controller with a reference to the view

do
{
  try button.initButton(opacity: 1.0, color: UIColor.black, selectedColor: UIColor.cyan, buttonScale: 0.6, animationDuration: 0.5, shadowOpacity: 0.4, shadowRadius: 1.0, shouldHaveSelectedColorAnimation: true)
}
catch ScalingGradientAnimatedButtonViewError.startGradientColorsAndLocationMismatch(let errorMessage)
{
  print(errorMessage)
}
catch
{
  print(error)
}

```

## Example Project

An example project is included with this repo. To run the example project, clone the repo, and run 'pod install' from the Example directory first

## Author

Antonio Ruffolo

## License

ScalingGradientAnimatedButton is available under the MIT license. See the LICENSE file for more info.
