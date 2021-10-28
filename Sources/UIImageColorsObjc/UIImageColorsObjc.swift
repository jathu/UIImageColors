//
//  UIImageColorsObjc.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 14.10.21.
//

#if canImport(UIKit)

import UIKit

#if SWIFT_PACKAGE
import UIImageColors
#endif

/// Represents the most common colors inside an image.
@objc(UIImageColors)
@objcMembers
public final class UIImageColorsObjc: NSObject {
    
    /// The most common, non-black/white color.
    public let background: UIColor
    
    /// The most common color that is contrasting with the background.
    public let primary: UIColor?
    
    /// The second most common color that is contrasting with the background.
    ///
    /// Also must distinguish itself from the ``primary`` color.
    public let secondary: UIColor?
    
    /// The third most common color that is contrasting with the background.
    ///
    /// Also must distinguish itself from the ``primary`` and ``secondary`` color.
    public let detail: UIColor?
    
    init(background: UIColor, primary: UIColor?, secondary: UIColor?, detail: UIColor?) {
        self.background = background
        self.primary = primary
        self.secondary = secondary
        self.detail = detail
        super.init()
    }
}

extension UIImage {
    
    /// Creates the ``UIImageColorsObjc`` synchronously.
    ///
    /// Calling this from the main-thread can create hitches!
    ///
    /// - Parameter quality: The scale quality.
    /// - Returns: The ``UIImageColorsObjc`` from the image.
    @objc(getColorsWithQuality:)
    public func getColorsObjc(quality: UIImageColorsScaleQuality) -> UIImageColorsObjc? {
        guard let colors = getColors(quality: quality._scaleQuality) else { return nil }
        return UIImageColorsObjc(background: colors.background, primary: colors.primary, secondary: colors.secondary, detail: colors.detail)
    }
    
    /// Creates the ``UIImageColorsObjc`` asynchronously.
    ///
    /// This will run the analyzation in the default global dispatch-queue.
    /// The completion get's pushed back to the main!
    ///
    /// - Parameters:
    ///   - quality: The scale quality.
    ///   - completion: The completion block with the ``UIImageColorsObjc``.
    @objc(getColorsWithQuality:completion:)
    public func getColorsObjc(quality: UIImageColorsScaleQuality, completion: @escaping (UIImageColorsObjc?) -> Void) {
        getColors(quality: quality._scaleQuality) { colors in
            if let colors = colors {
                completion(UIImageColorsObjc(background: colors.background, primary: colors.primary, secondary: colors.secondary, detail: colors.detail))
            } else {
                completion(nil)
            }
        }
    }
}

#endif
