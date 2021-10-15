//
//  _ColorCounter.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 04.10.21.
//

import Foundation
import CoreGraphics


// MARK: - _ColorCounter

internal struct _ColorCounter {
    
    internal var threshold: Int
    
    private var _imageRBGCounts: [_RGB: Int] = [:]
    
    internal init?(cgImage: CGImage) {
        guard let data = cgImage.dataProvider?.data as Data? else { return nil }
        
        self.threshold = Int(CGFloat(cgImage.height) * 0.01)
        
        for x in 0..<cgImage.width {
            for y in 0..<cgImage.height {
                let pixel: Int = (y * cgImage.bytesPerRow) + (x * 4)
                if data[pixel + 3] > 127 {
                    let red = Float(data[pixel + 2])
                    let green = Float(data[pixel + 1])
                    let blue = Float(data[pixel])
                    let rgb = _RGB(red: red, green: green, blue: blue)
                    _imageRBGCounts[rgb] = (_imageRBGCounts[rgb] ?? 0) + 1
                }
            }
        }
    }
}


// MARK: - _ColorCounter + counts

extension _ColorCounter {
    
    internal var counts: [_Count] {
        var counts: [_Count] = []
        for rgbCount in _imageRBGCounts where threshold < rgbCount.value {
            counts.append(_Count(rgb: rgbCount.key, count: rgbCount.value))
        }
        counts.sort { $0.count > $1.count }
        return counts
    }
    
    internal func saturatedCounts(findDarkTextColor: Bool) -> [_Count] {
        return _imageRBGCounts
            .compactMap { rgbCount -> _ColorCounter._Count? in
                let saturatedColor = rgbCount.key.with(minSaturation: 0.15)
                if saturatedColor.isDarkColor == findDarkTextColor {
                    let count = _imageRBGCounts[saturatedColor] ?? 0
                    return _ColorCounter._Count(rgb: saturatedColor, count: count)
                }
                return nil
            }
            .sorted { $0.count > $1.count }
    }
}


// MARK: - _ColorCounter._Count

extension _ColorCounter {
    
    internal struct _Count {
        let rgb: _RGB
        let count: Int
    }
}
