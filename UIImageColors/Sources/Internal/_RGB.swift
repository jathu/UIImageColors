//
//  _RGB.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 04.10.21.
//

import Foundation


// MARK: - _RGB

internal struct _RGB: Hashable {
    internal var red: Float
    internal var green: Float
    internal var blue: Float
}


// MARK: - _RGB + Constants

extension _RGB {
    
    static internal var black: _RGB {
        return _RGB(red: 0, green: 0, blue: 0)
    }
    
    static internal var white: _RGB {
        return _RGB(red: 255, green: 255, blue: 255)
    }
}


// MARK: - _RGB + Helpers

extension _RGB {
    
    internal var isDarkColor: Bool {
        return red * 0.2126 + green * 0.7152 + blue * 0.0722 < 127.5
    }
    
    internal var isBlackOrWhite: Bool {
        return (red > 232 && green > 232 && blue > 232) || (red < 23 && green < 23 && blue < 23)
    }
    
    internal func isDistinct(_ other: _RGB) -> Bool {
        let a = abs(red - other.red) > 63.75 || abs(green - other.green) > 63.75 || abs(blue - other.blue) > 63.75
        let b = abs(red - green) < 7.65 && abs(red - blue) < 7.65 && abs(other.red - other.green) < 7.65 && abs(other.red - other.blue) < 7.65
        return a && !b
    }
    
    internal func with(minSaturation: Float) -> _RGB {
        var hsv = _HSV(self)
        if hsv.saturation > minSaturation {
            return self
        }
        hsv.saturation = minSaturation
        return _RGB(hsv)
    }
    
    internal func isContrasting(with other: _RGB) -> Bool {
        let bgLum = (0.2126 * red) + (0.7152 * green) + (0.0722 * blue) + 12.75
        let fgLum = (0.2126 * other.red) + (0.7152 * other.green) + (0.0722 * other.blue) + 12.75
        if bgLum > fgLum {
            return 1.6 < bgLum / fgLum
        } else {
            return 1.6 < fgLum / bgLum
        }
    }
}


// MARK: - _RGB + _HSV Convert

extension _RGB {
    
    internal init(_ hsv: _HSV) {
        let c = (hsv.value / 100) * (hsv.saturation / 100)
        let x = c * (1 - abs((hsv.hue / 60).truncatingRemainder(dividingBy: 2) - 1))
        let m = hsv.value / 100 - c
        
        switch hsv.hue {
        case 0..<60:
            red = (c + m) * 255
            green = (x + m) * 255
            blue = (0 + m) * 255
        case 60..<120:
            red = (x + m) * 255
            green = (c + m) * 255
            blue = (0 + m) * 255
        case 120..<180:
            red = (0 + m) * 255
            green = (c + m) * 255
            blue = (x + m) * 255
        case 180..<240:
            red = (0 + m) * 255
            green = (x + m) * 255
            blue = (c + m) * 255
        case 240..<300:
            red = (x + m) * 255
            green = (0 + m) * 255
            blue = (c + m) * 255
        case 300..<360:
            red = (c + m) * 255
            green = (0 + m) * 255
            blue = (x + m) * 255
        default:
            red = 0
            green = 0
            blue = 0
        }
    }
}
