//
//  main.swift
//  macOS
//
//  Created by Felix Herrmann on 16.10.21.
//

import AppKit

let delegate = AppDelegate()
NSApplication.shared.delegate = delegate

let menu = NSMenu()
menu.addItem(withTitle: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
NSApplication.shared.mainMenu = menu

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
