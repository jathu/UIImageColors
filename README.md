[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjathu%2FUIImageColors%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/jathu/UIImageColors)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjathu%2FUIImageColors%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/jathu/UIImageColors)
[![Xcode Build](https://github.com/jathu/UIImageColors/actions/workflows/xcodebuild.yml/badge.svg)](https://github.com/jathu/UIImageColors/actions/workflows/xcodebuild.yml)

# UIImageColors

iTunes style color fetcher for `UIImage` and `NSImage`. It fetches the most dominant and prominent colors.

<p float="left">
  <img src="/preview-iphone.png" width="30%"/>
  <img src="/preview-macos.png" width="65%"/> 
</p>

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

Add the following to the dependencies of your `Package.swift`:

```swift
.package(url: "https://github.com/jathu/UIImageColors.git", from: "x.x.x")
```

### [CocoaPods](https://cocoapods.org)

Add UIImageColors to your [`Podfile`](https://cocoapods.org/pods/UIImageColors):

```
pod 'UIImageColors'
```

### [Carthage](https://github.com/Carthage/Carthage)

Add UIImageColors to your `Cartfile`:

```
github "jathu/UIImageColors"
```

### Manual

Copy the [UIImageColors](/Sources/UIImageColors) folder into your project.

For Objective-C projects copy the entire [Sources](/Sources) folder.

## Examples

<details>
  <summary>iOS (Swift)</summary>
  
  ```swift
  import UIImageColors
  
  let image = UIImage(named: "example.png")
  
  // Synchronous
  let colors = image.getColors()
  
  // Asynchronous(completion-handler)
  image.getColors { colors in
    
  }
  
  // Asynchronous(async/await)
  let colors = await image.colors()
  ```
  
</details>

<details>
  <summary>iOS (Objective-C)</summary>
  
  ```objc
  @import UIImageColorsObjc;
  
  UIImage *image = [UIImage imageNamed:@"example.png"];
  
  // Synchronous
  UIImageColors *colors = [image getColorsWithQuality:UIImageColorsScaleQualityHigh];
  
  // Asynchronous
  [image getColorsWithQuality:UIImageColorsScaleQualityHigh completion:^(UIImageColors * _Nullable colors) {
      
  }];
  ```
  
</details>

<details>
  <summary>macOS (Swift)</summary>
  
  ```swift
  import UIImageColors
  
  let image = NSImage(named: "example.png")
  
  // Synchronous
  let colors = image.getColors()
  
  // Asynchronous(completion-handler)
  image.getColors { colors in
    
  }
  
  // Asynchronous(async/await)
  let colors = await image.colors()
  ```
  
</details>

<details>
  <summary>macOS (Objective-C)</summary>
  
  ```objc
  @import UIImageColorsObjc;
  
  NSImage *image = [NSImage imageNamed:@"example.png"];
  
  // Synchronous
  NSImageColors *colors = [image getColorsWithQuality:UIImageColorsScaleQualityHigh];
  
  // Asynchronous
  [image getColorsWithQuality:UIImageColorsScaleQualityHigh completion:^(NSImageColors * _Nullable colors) {
      
  }];
  ```
  
</details>

## Colors-object

`Colors` is an object that contains four different color-properties and is used as the return type.

| Property   | Description                                                                                                                                 |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| background | The most common, non-black/white color.                                                                                                     |
| primary    | The most common color that is contrasting with the background.                                                                              |
| secondary  | The second most common color that is contrasting with the background. Also must distinguish itself from the `primary` color.                |
| detail     | The third most common color that is contrasting with the background. Also must distinguish itself from the `primary` and `secondary` color. |

In Swift `Colors` is a struct and an extension of `UIImage`/`NSImage`;
in Objective-C there is a `UIImageColors`/`NSImageColors` class which is a concrete subclass of `NSObject`.

## ScaleQuality-enum

`ScaleQuality` is an enum with four different qualities. The qualities refer to how much the original image is scaled down.
Higher qualities will give better results at the cost of performance.

| Value               | Quality     |
| ------------------- | ----------- |
| low                 | 50 pixel    |
| medium              | 100 pixel   |
| high                | 250 pixel   | 
| full                | no scaling  |
| custom (Swift only) | given value |

All methods provide a quality parameter (which is set to `.high` by default in Swift).

```swift
let colors = image.getColors(quality: .low)
let asyncColors = await image.colors(quality: .custom(10))
image.getColors(quality: .full) { colors in /*...*/ }
```

```objc
UIImageColors *colors = [image getColorsWithQuality:UIImageColorsScaleQualityLow];
[image getColorsWithQuality:UIImageColorsScaleQualityFull completion:^(NSImageColors * _Nullable colors) { /*...*/ }];
```

## License

The [license](https://github.com/jathu/UIImageColors/blob/master/LICENSE) is provided in the project folder. This is based on Panic's [OS X ColorArt](https://github.com/panicinc/ColorArt/#license).

------
June 2015 - Toronto
