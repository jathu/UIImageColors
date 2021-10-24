//
//  main.swift
//  macOS
//
//  Created by Felix Herrmann on 16.10.21.
//

import AppKit

let delegate = AppDelegate()
NSApplication.shared.delegate = delegate

let mainMenu = MainMenu()
NSApplication.shared.mainMenu = mainMenu

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
