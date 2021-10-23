//
//  AppDelegate.swift
//  macOS
//
//  Created by Felix Herrmann on 14.10.21.
//

import AppKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let contentRect = NSRect(origin: .zero, size: NSScreen.main?.frame.size ?? .zero)
        
        window = NSWindow(contentRect: contentRect, styleMask: [.miniaturizable, .closable, .resizable, .titled, .unifiedTitleAndToolbar, .fullSizeContentView], backing: .buffered, defer: false)
        
        window?.title = "macOS Example"
        window?.contentViewController = ViewController()
        window?.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
