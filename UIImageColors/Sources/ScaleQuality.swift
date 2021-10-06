//
//  ScaleQuality.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 05.10.21.
//

import CoreGraphics


// MARK: - ScaleQuality

/// The quality the original image should be scaled to.
public enum ScaleQuality {
    
    /// Scales the image to 50 pixel.
    case low
    
    /// Scales the image to 100 pixel.
    case medium
    
    /// Scales the image to 250 pixel.
    case high
    
    /// Does not scale the image.
    case full
    
    /// Scales the image to the given value.
    case custom(CGFloat)
}


// MARK: - ScaleQuality + scaleSize

extension ScaleQuality {
    
    internal func _scaleSize(_ size: CGSize) -> CGSize {
        let quality: CGFloat
        
        switch self {
        case .low:
            quality = 50
        case .medium:
            quality = 100
        case .high:
            quality = 250
        case .full:
            return size
        case .custom(let q):
            quality = q
        }
        
        if size.width < size.height {
            let ratio = size.height / size.width
            return CGSize(width: quality / ratio, height: quality)
        } else {
            let ratio = size.width / size.height
            return CGSize(width: quality, height: quality / ratio)
        }
    }
}
