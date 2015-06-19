# UIImageColors

iTunes style color fetcher for UIImage. This is an *almost* identical port of [Panic's OS X ColorArt](https://github.com/panicinc/ColorArt/) for Swift.

In other words, it fetches the most dominant and prominent colors.

![preview](images/preview.png)

# Documentation

This is pretty simple to use. Example:

```Swift
let image = UIImage(named: "hello.png")
let colors = image.getColors()

backgroundView.backgroundColor = colors.backgroundColor
mainLabel.textColor = colors.primaryColor
secondaryLabel.textColor = colors.secondaryColor
detailLabel.textColor = colors.detailColor
```

There is not point of testing this in Playground, as it takes **FOREVER** (unless you scale down to something really small). Its pretty fast in development.

## UIImage Methods

- **getColors(scaleDownSize: CGSize) -> UIImageColors**

Get an UIImageColors class from the image. Use smaller sizes for better performance at the cost of quality colors. Use larger sizes for better color sampling and quality at the cost of performance. 

- **getColors() -> UIImageColors**

Get an UIImageColors class from the image. The default image scale down is 250px width, and the aspect ratio height.

- **resize(newSize: CGSize) -> UIImage**

Resize your image.

## UIImageColors

UIImageColors simply contain four different colors.

- **backgroundColor -> UIColor**
- **primaryColor -> UIColor**
- **secondaryColor -> UIColor**
- **detailColor -> UIColor**

## UIColor Methods

As a result of testing colors for certain properties, UIColor get's some cool extensions. The functions are self-explanatory.

- **isDarkColor -> Bool**
- **isBlackOrWhite -> Bool**
- **isDistinct(compareColor: UIColor) -> Bool**
- **colorWithMinimumSaturation(minSaturation: CGFloat) -> UIColor**
- **isContrastingColor(compareColor: UIColor) -> Bool**

------
June 2015 - Toronto
