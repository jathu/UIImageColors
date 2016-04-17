# UIImageColors

iTunes style color fetcher for UIImage. This is an *almost* identical port of [Panic's OS X ColorArt](https://github.com/panicinc/ColorArt/) for iOS Swift.

In other words, it fetches the most dominant and prominent colors.

![preview](preview.png)

# Documentation

This is pretty simple to use:

```Swift
let image = UIImage(named: "hello.png")

image.getColors({ (colors) in
  backgroundView.backgroundColor = colors.backgroundColor
  mainLabel.textColor = colors.primaryColor
  secondaryLabel.textColor = colors.secondaryColor
  detailLabel.textColor = colors.detailColor
})

```

## UIImage Methods

- **getColors(scaleDownSize: CGSize, completionHandler: (UIImageColors) -> Void)**

Get an UIImageColors struct from the image. Use smaller sizes for better performance at the cost of quality colors. Use larger sizes for better color sampling and quality at the cost of performance.

- **getColors(completionHandler: (UIImageColors) -> Void)**

Get an UIImageColors struct from the image. The default image scale down is 250px width, and the aspect ratio height.

- **resize(newSize: CGSize) -> UIImage**

Resize your image.

## UIImageColors

UIImageColors simply contains four different UIColor.

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

## License

MIT License

Copyright (c) 2015 Jathu Satkunarajah

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

------
June 2015 - Toronto
