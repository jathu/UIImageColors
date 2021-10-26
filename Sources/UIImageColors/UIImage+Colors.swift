//
//  UIImage+Colors.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 05.10.21.
//

#if canImport(UIKit)

import UIKit


// MARK: - Colors

extension UIImage {
    
    /// Represents the most common colors inside an image.
    public struct Colors {
        
        /// The most common, non-back/white color.
        public let background: UIColor
        
        /// The most common color that is contrasting with the background.
        public let primary: UIColor?
        
        /// The second most common color that is contrasting with the background.
        ///
        /// Also must distinguish itself from the ``primary`` color.
        public let secondary: UIColor?
        
        /// The thrid most common color that is contrasting with the background.
        ///
        /// Also must distinguish itself from the ``primary`` and ``secondary`` color.
        public let detail: UIColor?
    }
}

extension UIImage {
    
    /// Creates the ``Colors`` synchronously.
    ///
    /// Calling this from the main-thread can create hitches!
    ///
    /// - Parameter quality: The scale quality. Default is `ScaleQuality.high`.
    /// - Returns: The ``Colors`` from the image.
    public func getColors(quality: ScaleQuality = .high) -> Colors? {
        let scaledSize = quality._scaleSize(size)
        guard let resizedCGImage = _resizedCGImage(size: scaledSize) else { return nil }
        guard let counter = _ColorCounter(cgImage: resizedCGImage) else { return nil }
        let analyzer = _ColorAnalyzer(counter: counter)
        return analyzer?.colors
    }
    
    /// Creates the ``Colors`` asynchronously.
    ///
    /// This will run the analyzation in the default global dispatch-queue.
    /// The completion get's pushed back to the main!
    ///
    /// - Parameters:
    ///   - quality: The scale quality. Default is `ScaleQuality.high`.
    ///   - completion: The completion block with the ``Colors``.
    public func getColors(quality: ScaleQuality = .high, _ completion: @escaping (Colors?) -> Void) {
        DispatchQueue.global().async {
            let result = self.getColors(quality: quality)
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    /// Creates the ``Colors`` asynchronously.
    ///
    /// - Parameter quality: The scale quality. Default is `ScaleQuality.high`.
    /// - Returns: The ``Colors`` from the image asynchronously.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public func colors(quality: ScaleQuality = .high) async -> Colors? {
        await withUnsafeContinuation { continuation in
            getColors(quality: quality) { colors in
                continuation.resume(returning: colors)
            }
        }
    }
}


// MARK: - Helpers

extension UIImage {
    
    internal func _resizedCGImage(size: CGSize) -> CGImage? {
        guard self.size != size else { return cgImage }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        guard let cgImage = cgImage else { return nil }
        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        return context?.makeImage()
    }
}

extension UIColor {
    
    internal convenience init(_ rgb: _RGB) {
        self.init(red: CGFloat(rgb.red) / 255, green: CGFloat(rgb.green) / 255, blue: CGFloat(rgb.blue) / 255, alpha: 1)
    }
}

extension _ColorAnalyzer {
    
    internal var colors: UIImage.Colors {
        let background = UIColor(backgroundRGB)
        let primary = primaryRGB.map { UIColor($0) }
        let secondary = secondaryRGB.map { UIColor($0) }
        let detail = detailRGB.map { UIColor($0) }
        return UIImage.Colors(background: background, primary: primary, secondary: secondary, detail: detail)
    }
}

#endif
