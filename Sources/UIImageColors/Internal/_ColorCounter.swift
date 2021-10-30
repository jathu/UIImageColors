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
        guard cgImage.colorSpace?.model == .rgb else { return nil }
        guard let pixelFormat = cgImage.bitmapInfo.pixelFormat else { return nil }
        guard let data = cgImage.dataProvider?.data, let bytes = CFDataGetBytePtr(data) else { return nil }
        
        self.threshold = Int(Float(cgImage.height) * 0.01)
        
        // Accessing the raw pixels
        // https://www.ralfebert.de/ios/examples/image-processing/uiimage-raw-pixels/
        
        let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent
        
        for x in 0..<cgImage.width {
            for y in 0..<cgImage.height {
                let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
                let rgba = pixelFormat.rgba(from: (bytes[offset], bytes[offset + 1], bytes[offset + 2], bytes[offset + 3]))
                if rgba.3 > 127 {
                    let red = Float(rgba.0)
                    let green = Float(rgba.1)
                    let blue = Float(rgba.2)
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


// MARK: - _PixelFormat + rgba(from:)

extension _PixelFormat {
    
    internal func rgba(from bytes: (UInt8, UInt8, UInt8, UInt8)) -> (UInt8, UInt8, UInt8, UInt8) {
        switch self {
        case .abgr:
            return (bytes.3, bytes.2, bytes.1, bytes.0)
        case .argb:
            return (bytes.3, bytes.0, bytes.1, bytes.2)
        case .bgra:
            return (bytes.2, bytes.1, bytes.0, bytes.3)
        case .rgba:
            return (bytes.0, bytes.1, bytes.2, bytes.3)
        }
    }
}
