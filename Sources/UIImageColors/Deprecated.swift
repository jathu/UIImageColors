//
//  Deprecated.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 05.10.21.
//

#if canImport(UIKit)

import UIKit

@available(*, deprecated, renamed: "UIImage.Colors")
public typealias UIImageColors = UIImage.Colors

#endif


#if canImport(AppKit)

import AppKit

@available(*, deprecated, renamed: "NSImage.Colors")
public typealias UIImageColors = NSImage.Colors

#endif


@available(*, deprecated, renamed: "ScaleQuality")
public typealias UIImageColorsQuality = ScaleQuality
