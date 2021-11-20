//
//  UIImageColorsScaleQuality.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 14.10.21.
//

import Foundation

#if SWIFT_PACKAGE
import UIImageColors
#endif // SWIFT_PACKAGE

/// The quality the original image should be scaled to.
@objc
public enum UIImageColorsScaleQuality: Int {
    
    /// Scales the image to 50 pixel.
    case low
    
    /// Scales the image to 100 pixel.
    case medium
    
    /// Scales the image to 250 pixel.
    case high
    
    /// Does not scale the image.
    case full
}

extension UIImageColorsScaleQuality {
    
    internal var _scaleQuality: ScaleQuality {
        switch self {
        case .low: return .low
        case .medium: return .medium
        case .high: return .high
        case .full: return .full
        }
    }
}
