//
//  DragAndDropImageView.swift
//  DominantColor
//
//  Created by Indragie on 12/19/14.
//  Copyright (c) 2014 Indragie Karunaratne. All rights reserved.
//

import Cocoa

@objc protocol DragAndDropImageViewDelegate {
    func dragAndDropImageView(imageView: DragAndDropImageView, droppedImage image: NSImage?)
}

class DragAndDropImageView: NSImageView {
    @IBOutlet weak var delegate: DragAndDropImageViewDelegate?

    private let filenameType = NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerForDraggedTypes([filenameType])
    }

    private func fileURL(for pasteboard: NSPasteboard) -> URL? {
        if let files = pasteboard.propertyList(forType: filenameType) as? [String] {
            guard let filename = files.first else { return nil }

            return URL(fileURLWithPath: filename)
        }
        return nil
    }

    // MARK: NSDraggingDestination

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let pasteboard = sender.draggingPasteboard
        if let fileURL = fileURL(for: pasteboard) {
            let pathExtension = fileURL.pathExtension as CFString
            guard let UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension, nil)?.takeRetainedValue() else { return [] }
            return (UTTypeConformsTo(UTI, kUTTypeImage) == true) ? .copy : []
        }
        return []
    }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let pasteboard = sender.draggingPasteboard
        if let fileURL = fileURL(for: pasteboard) {
            self.delegate?.dragAndDropImageView(imageView: self, droppedImage: NSImage(contentsOf: fileURL))
            return true
        }
        return false
    }
}
