//
//  NSImage+Colors.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 05.10.21.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit


// MARK: - Colors

extension NSImage {
    
    /// Represents the most common colors inside an image.
    public struct Colors {
        
        /// The most common, non-black/white color.
        public let background: NSColor
        
        /// The most common color that is contrasting with the background.
        public let primary: NSColor?
        
        /// The second most common color that is contrasting with the background.
        ///
        /// Also must distinguish itself from the ``primary`` color.
        public let secondary: NSColor?
        
        /// The third most common color that is contrasting with the background.
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
    
    #if canImport(_Concurrency)
    /// Creates the ``Colors`` asynchronously.
    ///
    /// - Parameter quality: The scale quality. Default is `ScaleQuality.high`.
    /// - Returns: The ``Colors`` from the image asynchronously.
    @available(macOS 12.0, *)
    public func colors(quality: ScaleQuality = .high) async -> Colors? {
        await withUnsafeContinuation { continuation in
            getColors(quality: quality) { colors in
                continuation.resume(returning: colors)
            }
        }
    }
    #endif // canImport(_Concurrency)
}


// MARK: - NSImage Helpers

extension NSImage {
    
    internal func _resizedCGImage(size: CGSize) -> CGImage? {
        guard self.size != size else {
            return cgImage(forProposedRect: nil, context: nil, hints: nil)
        }
        
        if let bitmapImageRep = NSBitmapImageRep(
            bitmapDataPlanes: nil,
            pixelsWide: Int(size.width),
            pixelsHigh: Int(size.height),
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: .calibratedRGB,
            bytesPerRow: 0,
            bitsPerPixel: 0
        ) {
            bitmapImageRep.size = size
            NSGraphicsContext.saveGraphicsState()
            NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmapImageRep)
            draw(in: NSRect(origin: .zero, size: size), from: .zero, operation: .copy, fraction: 1)
            NSGraphicsContext.restoreGraphicsState()
            
            let resizedImage = NSImage(size: size)
            resizedImage.addRepresentation(bitmapImageRep)
            return resizedImage.cgImage(forProposedRect: nil, context: nil, hints: nil)
        }
        
        return nil
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

#endif // canImport(AppKit) && !targetEnvironment(macCatalyst)
