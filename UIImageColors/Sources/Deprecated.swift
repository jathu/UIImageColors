//
//  Deprecated.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 05.10.21.
//

#if canImport(UIKit)

import UIKit

@available(*, deprecated, message: "Use UIImage.Colors instead.")
public typealias UIImageColors = UIImage.Colors

#endif


#if canImport(AppKit)

import AppKit

@available(*, deprecated, message: "Use NSImage.Colors instead.")
public typealias UIImageColors = NSImage.Colors

#endif


@available(*, deprecated, message: "Use ScaleQuality instead.")
public typealias UIImageColorsQuality = ScaleQuality
