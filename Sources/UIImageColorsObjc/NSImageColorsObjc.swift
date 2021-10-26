//
//  NSImageColorsObjc.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 14.10.21.
//

import Foundation
import UIImageColors

#if canImport(AppKit)

import AppKit
import UIImageColors

/// Represents the most common colors inside an image.
@objc(NSImageColors)
@objcMembers
public final class NSImageColorsObjc: NSObject {
    
    /// The most common, non-black/white color.
    public let background: NSColor
    
    /// The most common color that is contrasting with the background.
    public let primary: NSColor?
    
    /// The second most common color that is contrasting with the background.
    ///
    /// Also must distinguish itself from the ``primary`` color.
    public let secondary: NSColor?
    
    /// The thrid most common color that is contrasting with the background.
    ///
    /// Also must distinguish itself from the ``primary`` and ``secondary`` color.
    public let detail: NSColor?
    
    init(background: NSColor, primary: NSColor?, secondary: NSColor?, detail: NSColor?) {
        self.background = background
        self.primary = primary
        self.secondary = secondary
        self.detail = detail
        super.init()
    }
}

extension NSImage {
    
    /// Creates the ``NSImageColorsObjc`` synchronously.
    ///
    /// Calling this from the main-thread can create hitches!
    ///
    /// - Parameter quality: The scale quality.
    /// - Returns: The ``NSImageColorsObjc`` from the image.
    @objc(getColorsWithQuality:)
    public func getColorsObjc(quality: UIImageColorsScaleQuality) -> NSImageColorsObjc? {
        guard let colors = getColors(quality: quality._scaleQuality) else { return nil }
        return NSImageColorsObjc(background: colors.background, primary: colors.primary, secondary: colors.secondary, detail: colors.detail)
    }
    
    /// Creates the ``NSImageColorsObjc`` asynchronously.
    ///
    /// This will run the analyzation in the default global dispatch-queue.
    /// The completion get's pushed back to the main!
    ///
    /// - Parameters:
    ///   - quality: The scale quality.
    ///   - completion: The completion block with the ``NSImageColorsObjc``.
    @objc(getColorsWithQuality:completion:)
    public func getColorsObjc(quality: UIImageColorsScaleQuality, completion: @escaping (NSImageColorsObjc?) -> Void) {
        getColors(quality: quality._scaleQuality) { colors in
            if let colors = colors {
                completion(NSImageColorsObjc(background: colors.background, primary: colors.primary, secondary: colors.secondary, detail: colors.detail))
            } else {
                completion(nil)
            }
        }
    }
}

#endif
