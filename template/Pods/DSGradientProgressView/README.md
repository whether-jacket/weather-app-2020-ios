# DSGradientProgressView

![Swift Version](https://img.shields.io/badge/swift-4.2-green.svg)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/DSGradientProgressView.svg)](http://cocoapods.org/pods/DSGradientProgressView)
[![Platform](https://img.shields.io/cocoapods/p/DSGradientProgressView.svg)](http://cocoapods.org/pods/DSGradientProgressView)

## Introduction
`DSGradientProgressView` is a simple and customizable animated progress bar written in Swift.
>Inspired by [GradientProgressView](https://github.com/nrj/GradientProgressView).

## Demo
![Demo gif](https://github.com/DholStudio/DSGradientProgressView/raw/master/animation.gif)
>The gif looks flickery, but the actual animation on device will not be.

## Usage
Simply drop a `UIView` into your View Controller in the Storyboard. Select your view and, in the `Identity Inspector`, change the class to `DSGradientProgressView`. 
>Don't forget to change the module to `DSGradientProgressView` too.

![Demo set class](https://github.com/DholStudio/DSGradientProgressView/raw/master/set_class.png)

Size the view according to your needs. (A 3px height looks great in most cases).

Import `DSGradientProgressView` in your view controller source file.
```swift 
import DSGradientProgressView
```
Create an `IBOutlet` of the view in your view controller source file.
```swift 
@IBOutlet weak var progressView: DSGradientProgressView!
```
### Customize
You can change the base color of the progress bar. There are two ways to do this:

- By setting the `barColor` property of the view object in your source file.
```swift
progressView.barColor = UIColor.green
```
+ Changing the Bar Color property in Storyboard itself.

![Demo color picker](https://github.com/DholStudio/DSGradientProgressView/raw/master/color_picker.png)

### Animate
`DSGradientProgressView` is designed to keep track of the number of requests waiting for completion. Hence the api's are named after semaphore method names. You call the `wait()` method of the `DSGradientProgressView` to start animating and `signal()` method to stop. It hides and un-hides itself accordingly.

```swift
progressView.wait()
  // waiting for some resource
progressView.signal()
```

So, if your View Controller is waiting for more than one network request (or any other resource) and you want the Progress Bar to animate until all the requests are over, you can do that by simply calling `wait()` that number of times. Later, call `signal()` the same number of times.

```swift
progressView.wait()
  // waiting for some resource asynchronously
ResourceOne.sharedInstance.fetchData { (data, error) in
         self.progressView.signal()
}

progressView.wait()
  // waiting for another resource asynchronously
ResourceTwo.sharedInstance.fetchData { (data, error) in
         self.progressView.signal()
}

```

## Installation

### CocoaPods (Recommended)

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build DSGradientProgressView 1.0.0+.

To integrate DSGradientProgressView into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'DSGradientProgressView'
end
```

Then, run the following command:

```bash
$ pod install
```

### Manually

Copy the `DSGradientProgressView.swift` to your Xcode project. That should do it.

## Requirements

- iOS 8.0+
- Xcode 10.0+
- Swift 4.2+

## Contacts

* Created and maintained by [**@abhinavtyagi**](https://twitter.com/abhinavtyagi)

