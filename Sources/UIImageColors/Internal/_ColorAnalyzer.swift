//
//  _ColorAnalyzer.swift
//  UIImageColors
//
//  Created by Felix Herrmann on 04.10.21.
//

import Foundation


// MARK: - _ColorAnalyzer

internal struct _ColorAnalyzer {
    
    internal let backgroundRGB: _RGB
    private(set) internal var primaryRGB: _RGB?
    private(set) internal var secondaryRGB: _RGB?
    private(set) internal var detailRGB: _RGB?
    
    internal init?(counter: _ColorCounter) {
        let counts = counter.counts
        
        guard var count = counts.first else { return nil }
        
        if count.rgb.isBlackOrWhite {
            for colorCount in counts.dropFirst() {
                if Double(colorCount.count) / Double(count.count) > 0.3 {
                    if !colorCount.rgb.isBlackOrWhite {
                        count = colorCount
                        break
                    }
                } else {
                    break
                }
            }
        }
        
        backgroundRGB = count.rgb
        
        for count in counter.saturatedCounts(findDarkTextColor: !backgroundRGB.isDarkColor) {
            let rgb = count.rgb
            
            if primaryRGB == nil {
                if rgb.isContrasting(with: backgroundRGB) {
                    primaryRGB = rgb
                }
            } else if secondaryRGB == nil {
                if !rgb.isContrasting(with: backgroundRGB) || primaryRGB?.isDistinct(rgb) == false {
                    continue
                }
                secondaryRGB = rgb
            } else if detailRGB == nil {
                if !rgb.isContrasting(with: backgroundRGB) || secondaryRGB?.isDistinct(rgb) == false || primaryRGB?.isDistinct(rgb) == false {
                    continue
                }
                detailRGB = rgb
                break
            }
        }
    }
}
