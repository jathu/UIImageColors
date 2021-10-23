//
//  NSLabel.swift
//  macOS
//
//  Created by Felix Herrmann on 22.10.21.
//

import AppKit

final class NSLabel: NSTextField {
    
    
    // MARK: - Properties
    
    var text: String {
        get {
            return stringValue
        }
        set {
            stringValue = newValue
        }
    }
    
    
    // MARK: - Initializers
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        lineBreakMode = .byTruncatingTail
        maximumNumberOfLines = 1
        isBezeled = false
        drawsBackground = false
        isEditable = false
        isSelectable = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
