//
//  _PixelFormat.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 23.10.21.
//

import CoreGraphics

extension CGBitmapInfo {
    
    internal enum _PixelFormat {
        case abgr
        case argb
        case bgra
        case rgba
    }
    
    /// [Source](https://newbedev.com/getting-pixel-format-from-cgimage)
    internal var pixelFormat: _PixelFormat? {

        // AlphaFirst – the alpha channel is next to the red channel, argb and bgra are both alpha first formats.
        // AlphaLast – the alpha channel is next to the blue channel, rgba and abgr are both alpha last formats.
        // LittleEndian – blue comes before red, bgra and abgr are little endian formats.
        // Little endian ordered pixels are BGR (BGRX, XBGR, BGRA, ABGR, BGR).
        // BigEndian – red comes before blue, argb and rgba are big endian formats.
        // Big endian ordered pixels are RGB (XRGB, RGBX, ARGB, RGBA, RGB).

        let alphaInfo = CGImageAlphaInfo(rawValue: rawValue & type(of: self).alphaInfoMask.rawValue)
        let alphaFirst = alphaInfo == .premultipliedFirst || alphaInfo == .first || alphaInfo == .noneSkipFirst
        let alphaLast = alphaInfo == .premultipliedLast || alphaInfo == .last || alphaInfo == .noneSkipLast
        let endianLittle = contains(.byteOrder32Little)

        // This is slippery… while byte order host returns little endian, default bytes are stored in big endian
        // format. Here we just assume if no byte order is given, then simple RGB is used, aka big endian, though…

        if alphaFirst && endianLittle {
            return .bgra
        } else if alphaFirst {
            return .argb
        } else if alphaLast && endianLittle {
            return .abgr
        } else if alphaLast {
            return .rgba
        } else {
            return nil
        }
    }
}
