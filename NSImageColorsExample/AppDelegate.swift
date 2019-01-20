//
//  AppDelegate.swift
//  NSImageColorsExample
//
//  Created by Boy van Amstel on 20/01/2019.
//  Copyright © 2019 Jathu Satkunarajah. All rights reserved.
//

import Cocoa
import NSImageColors

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var imageView: DragAndDropImageView!
    @IBOutlet weak var backgroundColorBox: NSBox!
    @IBOutlet weak var primaryColorBox: NSBox!
    @IBOutlet weak var secondaryColorBox: NSBox!
    @IBOutlet weak var detailColorBox: NSBox!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

extension AppDelegate: DragAndDropImageViewDelegate {
    func dragAndDropImageView(imageView: DragAndDropImageView, droppedImage image: NSImage?) {
        guard let image = image else { return }

        imageView.image = image
        imageView.imageFrameStyle = .none

        image.getColors { (colors) in
            guard let colors = colors, let layer = self.window.contentView?.layer else { return }

            layer.backgroundColor = colors.background.cgColor

            self.backgroundColorBox.layer?.backgroundColor = colors.background.cgColor
            self.primaryColorBox.layer?.backgroundColor = colors.primary.cgColor
            self.secondaryColorBox.layer?.backgroundColor = colors.secondary.cgColor
            self.detailColorBox.layer?.backgroundColor = colors.detail.cgColor
        }
    }
}
