//
//  NSImageColors.swift
//  https://github.com/jathu/NSImageColors
//
//  Created by Jathu Satkunarajah (@jathu) on 2015-06-11 - Toronto
//  Adapted for OS X by John Wells
//  Original Cocoa version by Panic Inc. - Portland
//

import Cocoa

public struct NSImageColors {
    public var backgroundColor: NSColor!
    public var primaryColor: NSColor!
    public var secondaryColor: NSColor!
    public var detailColor: NSColor!
}

class PCCountedColor {
    let color: NSColor
    let count: Int
    
    init(color: NSColor, count: Int) {
        self.color = color
        self.count = count
    }
}

extension NSColor {
    
    public var isDarkColor: Bool {
        let RGB = CGColorGetComponents(self.CGColor)
        return (0.2126 * RGB[0] + 0.7152 * RGB[1] + 0.0722 * RGB[2]) < 0.5
    }
    
    public var isBlackOrWhite: Bool {
        let RGB = CGColorGetComponents(self.CGColor)
        return (RGB[0] > 0.91 && RGB[1] > 0.91 && RGB[2] > 0.91) || (RGB[0] < 0.09 && RGB[1] < 0.09 && RGB[2] < 0.09)
    }
    
    public func isDistinct(compareColor: NSColor) -> Bool {
        let bg = CGColorGetComponents(self.CGColor)
        let fg = CGColorGetComponents(compareColor.CGColor)
        let threshold: CGFloat = 0.25
        
        if fabs(bg[0] - fg[0]) > threshold || fabs(bg[1] - fg[1]) > threshold || fabs(bg[2] - fg[2]) > threshold {
            if fabs(bg[0] - bg[1]) < 0.03 && fabs(bg[0] - bg[2]) < 0.03 {
                if fabs(fg[0] - fg[1]) < 0.03 && fabs(fg[0] - fg[2]) < 0.03 {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    public func colorWithMinimumSaturation(minSaturation: CGFloat) -> NSColor {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        if saturation < minSaturation {
            return NSColor(hue: hue, saturation: minSaturation, brightness: brightness, alpha: alpha)
        } else {
            return self
        }
    }
    
    public func isContrastingColor(compareColor: NSColor) -> Bool {
        let bg = CGColorGetComponents(self.CGColor)
        let fg = CGColorGetComponents(compareColor.CGColor)
        
        let bgLum = 0.2126 * bg[0] + 0.7152 * bg[1] + 0.0722 * bg[2]
        let fgLum = 0.2126 * fg[0] + 0.7152 * fg[1] + 0.0722 * fg[2]
        let contrast = (bgLum > fgLum) ? (bgLum + 0.05)/(fgLum + 0.05):(fgLum + 0.05)/(bgLum + 0.05)
        
        return 1.6 < contrast
    }
    
}

extension NSImage {
    
    public func resize(newSize: CGSize) -> NSImage {
        let newImage = NSImage(size: newSize)
        newImage.lockFocus()
        self.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        newImage.unlockFocus()
        
        return newImage
    }
    
    public func getColors() -> NSImageColors {
        let ratio = self.size.width/self.size.height
        let r_width: CGFloat = 250
        return self.getColors(CGSizeMake(r_width, r_width/ratio))
    }
    
    public func getColors(scaleDownSize: CGSize) -> NSImageColors {
        var result = NSImageColors()
        
        var proposedRect = CGRect(origin: CGPointZero, size: scaleDownSize)
        let cgImage = self.resize(scaleDownSize).CGImageForProposedRect(&proposedRect,
                                                                        context: NSGraphicsContext.currentContext(),
                                                                        hints: nil)
        let width = CGImageGetWidth(cgImage)
        let height = CGImageGetHeight(cgImage)
        
        let bytesPerPixel: Int = 4
        let bytesPerRow: Int = width * bytesPerPixel
        let bitsPerComponent: Int = 8
        let randomColorsThreshold = Int(CGFloat(height)*0.01)
        let sortedColorComparator: NSComparator = { (main, other) -> NSComparisonResult in
            let m = main as! PCCountedColor, o = other as! PCCountedColor
            if m.count < o.count {
                return NSComparisonResult.OrderedDescending
            } else if m.count == o.count {
                return NSComparisonResult.OrderedSame
            } else {
                return NSComparisonResult.OrderedAscending
            }
        }
        let blackColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
        let whiteColor = NSColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let raw = malloc(bytesPerRow * height)
        let bitmapInfo = CGImageAlphaInfo.PremultipliedFirst.rawValue
        let ctx = CGBitmapContextCreate(raw, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo)
        CGContextDrawImage(ctx, CGRectMake(0, 0, CGFloat(width), CGFloat(height)), cgImage)
        let data = UnsafePointer<UInt8>(CGBitmapContextGetData(ctx))
        
        let leftEdgeColors = NSCountedSet(capacity: height)
        let imageColors = NSCountedSet(capacity: width * height)
        
        for x in 0..<width {
            for y in 0..<height {
                let pixel = ((width * y) + x) * bytesPerPixel
                let color = NSColor(
                    red: CGFloat(data[pixel+1])/255,
                    green: CGFloat(data[pixel+2])/255,
                    blue: CGFloat(data[pixel+3])/255,
                    alpha: 1
                )
                
                // A lot of albums have white or black edges from crops, so ignore the first few pixels
                if 5 <= x && x <= 10 {
                    leftEdgeColors.addObject(color)
                }
                
                imageColors.addObject(color)
            }
        }
        
        // Get background color
        var enumerator = leftEdgeColors.objectEnumerator()
        var sortedColors = NSMutableArray(capacity: leftEdgeColors.count)
        while let kolor = enumerator.nextObject() as? NSColor {
            let colorCount = leftEdgeColors.countForObject(kolor)
            if randomColorsThreshold < colorCount  {
                sortedColors.addObject(PCCountedColor(color: kolor, count: colorCount))
            }
        }
        sortedColors.sortUsingComparator(sortedColorComparator)
        
        var proposedEdgeColor: PCCountedColor
        if 0 < sortedColors.count {
            proposedEdgeColor = sortedColors.objectAtIndex(0) as! PCCountedColor
        } else {
            proposedEdgeColor = PCCountedColor(color: blackColor, count: 1)
        }
        
        if proposedEdgeColor.color.isBlackOrWhite && 0 < sortedColors.count {
            for i in 1..<sortedColors.count {
                let nextProposedEdgeColor = sortedColors.objectAtIndex(i) as! PCCountedColor
                if (CGFloat(nextProposedEdgeColor.count)/CGFloat(proposedEdgeColor.count)) > 0.3 {
                    if !nextProposedEdgeColor.color.isBlackOrWhite {
                        proposedEdgeColor = nextProposedEdgeColor
                        break
                    }
                } else {
                    break
                }
            }
        }
        result.backgroundColor = proposedEdgeColor.color
        
        // Get foreground colors
        enumerator = imageColors.objectEnumerator()
        sortedColors.removeAllObjects()
        sortedColors = NSMutableArray(capacity: imageColors.count)
        let findDarkTextColor = !result.backgroundColor.isDarkColor
        
        while var kolor = enumerator.nextObject() as? NSColor {
            kolor = kolor.colorWithMinimumSaturation(0.15)
            if kolor.isDarkColor == findDarkTextColor {
                let colorCount = imageColors.countForObject(kolor)
                sortedColors.addObject(PCCountedColor(color: kolor, count: colorCount))
            }
        }
        sortedColors.sortUsingComparator(sortedColorComparator)
        
        for curContainer in sortedColors {
            let kolor = (curContainer as! PCCountedColor).color
            
            if result.primaryColor == nil {
                if kolor.isContrastingColor(result.backgroundColor) {
                    result.primaryColor = kolor
                }
            } else if result.secondaryColor == nil {
                if !result.primaryColor.isDistinct(kolor) || !kolor.isContrastingColor(result.backgroundColor) {
                    continue
                }
                
                result.secondaryColor = kolor
            } else if result.detailColor == nil {
                if !result.secondaryColor.isDistinct(kolor) || !result.primaryColor.isDistinct(kolor) || !kolor.isContrastingColor(result.backgroundColor) {
                    continue
                }
                
                result.detailColor = kolor
                break
            }
        }
        
        let isDarkBackgound = result.backgroundColor.isDarkColor
        
        if result.primaryColor == nil {
            result.primaryColor = isDarkBackgound ? whiteColor:blackColor
        }
        
        if result.secondaryColor == nil {
            result.secondaryColor = isDarkBackgound ? whiteColor:blackColor
        }
        
        if result.detailColor == nil {
            result.detailColor = isDarkBackgound ? whiteColor:blackColor
        }
        
        // Release the allocated memory
        free(raw)
        
        return result
    }
    
}