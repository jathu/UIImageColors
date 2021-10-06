//
//  NSImage+Colors.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 05.10.21.
//

#if canImport(AppKit)

import AppKit


// MARK: - Colors

extension NSImage {
    
    /// Represents the most common colors inside an image.
    public struct Colors {
        
        /// The most common, non-back/white color.
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
    }
}

extension NSImage {
    
    /// Creates the ``Colors`` synchronously.
    ///
    /// Calling this from the main-thread can create hitches!
    ///
    /// - Parameter quality: The scale quality. Default is `ScaleQuality.high`.
    /// - Returns: The ``Colors`` from the image.
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
    /// This will run the analyzation in the default global dispatch-queue.
    /// The completion get's pushed back to the main!
    ///
    /// - Parameters:
    ///   - quality: The scale quality. Default is `ScaleQuality.high`.
    ///   - completion: The completion block with the ``Colors``.
    public func getColors(quality: ScaleQuality = .high) -> Colors? {
        let scaledSize = quality._scaleSize(size)
        guard let resizedCGImage = _resizedCGImage(size: scaledSize) else { return nil }
        guard let counter = _ColorCounter(cgImage: resizedCGImage) else { return nil }
        let analyzer = _ColorAnalyzer(counter: counter)
        return analyzer?.colors
    }
    
    // TODO: Make this available when macOS 12 is out.
//    /// Creates the ``Colors`` asynchronously.
//    ///
//    /// - Parameter quality: The scale quality. Default is `ScaleQuality.high`.
//    /// - Returns: The ``Colors`` from the image asynchronously.
//    @available(macOS 12.0, *)
//    public func colors(quality: ScaleQuality = .high) async -> Colors? {
//        await withUnsafeContinuation { continuation in
//            getColors { colors in
//                continuation.resume(returning: colors)
//            }
//        }
//    }
}


// MARK: - NSImage Helpers

extension NSImage {
    
    internal func _resizedCGImage(size: CGSize) -> CGImage? {
        // macOS creates different results compared to iOS!
        // Using the iOS way (with CGContext, https://stackoverflow.com/a/27613155/11342085) is not working at all.
        let frame = CGRect(origin: .zero, size: size)
        guard let representation = bestRepresentation(for: frame, context: nil, hints: nil) else { return nil }
        let result = NSImage(size: size, flipped: false) { _ in
            return representation.draw(in: frame)
        }
        return result.cgImage(forProposedRect: nil, context: nil, hints: nil)
    }
}

extension NSColor {
    
    internal convenience init(_ rgb: _RGB) {
        self.init(red: CGFloat(rgb.red) / 255, green: CGFloat(rgb.green) / 255, blue: CGFloat(rgb.blue) / 255, alpha: 1)
    }
}

extension _ColorAnalyzer {
    
    internal var colors: NSImage.Colors {
        let background = NSColor(backgroundRGB)
        let primary = primaryRGB.map { NSColor($0) }
        let secondary = secondaryRGB.map { NSColor($0) }
        let detail = detailRGB.map { NSColor($0) }
        return NSImage.Colors(background: background, primary: primary, secondary: secondary, detail: detail)
    }
}

#endif
