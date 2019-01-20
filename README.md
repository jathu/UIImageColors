![platform: iOS, tvOS and macOS](https://img.shields.io/badge/platform-iOS%20%7C%20tvOS%20%7C%20macOS-lightgrey.svg)

# UIImageColors

iTunes style color fetcher for `UIImage` and `NSImage`. It fetches the most dominant and prominent colors.

![iOS preview](preview-ios.png)
![macOS preview](preview-macos.jpg)

## Installation

### Manually

Copy [UIImageColors.swift](Sources/UIImageColors.swift) into your project.

### [Cocoapods](https://cocoapods.org)

Add UIImageColors to your [`Podfile`](https://cocoapods.org/pods/UIImageColors):

```
pod 'UIImageColors'
```

### [Carthage](https://github.com/Carthage/Carthage)

Add UIImageColors to your `Cartfile`:

```
github "jathu/UIImageColors"
```

## Example

Asynchronous example:

```swift
let image = UIImage(named: "yeezus.png")

image.getColors { colors in
  backgroundView.backgroundColor = colors.background
  mainLabel.textColor = colors.primary
  secondaryLabel.textColor = colors.secondary
  detailLabel.textColor = colors.detail
}
```

Synchronous example:

```swift
let colors = UIImage(named: "yeezus.png").getColors()

backgroundView.backgroundColor = colors.background
mainLabel.textColor = colors.primary
secondaryLabel.textColor = colors.secondary
detailLabel.textColor = colors.detail
```

## Image Methods

```swift
getColors() -> ImageColors?
getColors(quality: ImageColorsQuality) -> ImageColors?
getColors(_ completion: (ImageColors?) -> Void) -> Void
getColors(quality: ImageColorsQuality, _ completion: (ImageColors?) -> Void) -> Void
```

## ImageColors Objects

`ImageColors` is struct that contains four different `UIColor` (or `NSColor` on macOS) variables.

```swift
public struct ImageColors {
    public var background: UIColor!
    public var primary: UIColor!
    public var secondary: UIColor!
    public var detail: UIColor!
}
```

`ImageColorsQuality` is a enum with four different qualities. The qualities refer to how much the original image is scaled down. `Lowest` implies smaller size and faster performance at the cost of quality colors. `High` implies larger size with slower performance with good colors. `Highest` implies no downscaling and very good colors, but it is very slow.

The default is set to `high`.

```swift
public enum ImageColorsQuality: CGFloat {
    case lowest = 50 // 50px
    case low = 100 // 100px
    case high = 250 // 250px
    case highest = 0 // No scale
}
```

## License

The [license](https://github.com/jathu/UIImageColors/blob/master/LICENSE) is provided in the project folder. This is based on Panic's [OS X ColorArt](https://github.com/panicinc/ColorArt/#license).

------
June 2015 - Toronto
