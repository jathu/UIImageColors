# UIImageColors

iTunes style color fetcher for UIImage. This is an *almost* identical port of [Panic's OS X ColorArt](https://github.com/panicinc/ColorArt/) for iOS Swift.

In other words, it fetches the most dominant and prominent colors.

![preview](preview.png)

## Example

Asynchronous example:

```swift
let image = UIImage(named: "yeezus.png")

image.getColors { colors in
  backgroundView.backgroundColor = colors.backgroundColor
  mainLabel.textColor = colors.primaryColor
  secondaryLabel.textColor = colors.secondaryColor
  detailLabel.textColor = colors.detailColor
}
```

Synchronous example:

```swift
let colors = UIImage(named: "yeezus.png").getColors()

backgroundView.backgroundColor = colors.backgroundColor
mainLabel.textColor = colors.primaryColor
secondaryLabel.textColor = colors.secondaryColor
detailLabel.textColor = colors.detailColor
```

## UIImage Methods

```swift
getColors() -> UIImageColors
```

Returns a `UIImageColors` object. The sample image is rescaled to a width of 250px and the aspect ratio height. This blocks the main thread.

```swift
getColors(scaleDownSize: CGSize) -> UIImageColors
```

Returns a `UIImageColors` object with a custom image rescale. Use smaller sizes for better performance at the cost of quality colors. Use larger sizes for better color sampling and quality at the cost of performance. This blocks the main thread.

```swift
getColors(completionHandler: (UIImageColors) -> Void) -> Void
```

Passes a `UIImageColors` object into the closure. The sample image is rescaled to a width of 250px and the aspect ratio height. This runs on the background thread.

```swift
getColors(scaleDownSize: CGSize, completionHandler: (UIImageColors) -> Void) -> Void
```

Passes a `UIImageColors` object into the closure, with a custom image rescale. Use smaller sizes for better performance at the cost of quality colors. Use larger sizes for better color sampling and quality at the cost of performance. This runs on the background thread.

## UIImageColors

`UIImageColors` is struct that contains four different `UIColor`s.

```swift
var backgroundColor
var primaryColor
var secondaryColor
var detailColor
```

## License

The [license](https://github.com/jathu/UIImageColors/blob/master/LICENSE) is provided in the project folder. Please also refer to Panic's [original license](https://github.com/panicinc/ColorArt/#license).

------
June 2015 - Toronto
