//
//  _HSV.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 04.10.21.
//

import Foundation


// MARK: - _HSV

internal struct _HSV {
    internal var hue: Float
    internal var saturation: Float
    internal var value: Float
}


// MARK: - _HSV + _RGB Convert

extension _HSV {

    internal init(_ rgb: _RGB) {
        let r = rgb.red / 255
        let g = rgb.green / 255
        let b = rgb.blue / 255
        
        let cMin = min(r, min(g, b))
        let cMax = max(r, max(g, b))
        let delta = cMax - cMin
        
        if delta > 0 {
            let h: Float
            if cMax == r {
                h = 60 * ((g - b) / delta).truncatingRemainder(dividingBy: 6)
            } else if cMax == g {
                h = 60 * (((b - r) / delta) + 2)
            } else if cMax == b {
                h = 60 * (((r - g) / delta) + 4)
            } else {
                h = 0
            }
            
            hue = h < 0 ? 360 + h : h
        } else {
            hue = 0
        }
        
        saturation = cMax == 0 ? 0 : delta / cMax * 100
        value = cMax * 100
    }
}
