//
//  Helpers.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 26.10.21.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif


// MARK: - Example Path

internal func examplePath() -> String {
    var url = URL(fileURLWithPath: #filePath)
    url.deleteLastPathComponent()
    url.deleteLastPathComponent()
    url.deleteLastPathComponent()
    url.appendPathComponent("Example")
    url.appendPathComponent("Shared")
    url.appendPathComponent("Assets.xcassets")
    url.appendPathComponent("Calvin Klein - Kaws.imageset/Calvin Klein - Kaws.jpg")
    return url.path
}


// MARK: - Color + RGB

#if canImport(UIKit)

extension UIColor {
    
    internal var rgb: (Int, Int, Int) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (Int((red * 255).rounded()), Int((green * 255).rounded()), Int((blue * 255).rounded()))
    }
}

#elseif canImport(AppKit)

extension NSColor {
    
    internal var rgb: (Int, Int, Int) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (Int((red * 255).rounded()), Int((green * 255).rounded()), Int((blue * 255).rounded()))
    }
}

#endif
