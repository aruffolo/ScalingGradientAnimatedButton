# ScalingGradientAnimatedButton

[![Version](https://img.shields.io/cocoapods/v/ScalingGradientAnimatedButton.svg?style=flat)](http://cocoapods.org/pods/ScalingGradientAnimatedButton)
[![License](https://img.shields.io/cocoapods/l/ScalingGradientAnimatedButton.svg?style=flat)](http://cocoapods.org/pods/ScalingGradientAnimatedButton)
[![Platform](https://img.shields.io/cocoapods/p/ScalingGradientAnimatedButton.svg?style=flat)](http://cocoapods.org/pods/ScalingGradientAnimatedButton)

## Overview

ScalingGradientAnimatedButton is a subclass of UIView, written is Swift, that encloses a gradient and a scale animation in a view.

![](ButtonScreen.PNG?raw=true "Button Screenshoot in 'A Complex Calc")
![](ButtonScreenLeft.PNG?raw=true "Button Screenshoot in 'A Complex Calc")

You can see those buttons in the iOS App: 'A Complex Calc': https://tinyurl.com/y9vnsmzx

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

Four inizialization functions are included to provide enough customization.

```Swift

import ScalingGradientAnimatedButton

/// then inside the viewDidLoad or any view controller with a reference to the view

// init the button with two different colors for the selected and the unselected state, their transition can be animated or not
button.initButton(opacity: 1.0, color: UIColor.black, selectedColor: UIColor.cyan, buttonScale: 0.6, animationDuration: 0.5, shadowOpacity: 0.4, shadowRadius: 1.0, shouldHaveSelectedColorAnimation: true)

// init the button with just one color, only the scale will be animated
button.initButton(opacity: 1.0, color: UIColor.cyan, buttonScale: 1.3, animationDuration: 0.5, shadowOpacity: 0.6, shadowRadius: 1.0)
```

Set the position of the button to anchor its animation

```Swift
button.buttonPosition = .left

```

To intercept events arriving on the button assign this closure, it pass the tag of the view as a parameter. You can set the tag from ther storyboard

```Swift
button.calculatorButtonEvent = { tag in
  print("Tap or long press received")
}
```

## Author

Antonio Ruffolo

## License

ScalingGradientAnimatedButton is available under the MIT license. See the LICENSE file for more info.
