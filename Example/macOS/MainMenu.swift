//
//  MainMenu.swift
//  macOS
//
//  Created by Felix Herrmann on 24.10.21.
//

import AppKit

final class MainMenu: NSMenu {
    
    override init(title: String) {
        super.init(title: title)
        
        let mainAppMenuItem = NSMenuItem(title: "Main", action: nil, keyEquivalent: "")
        addItem(mainAppMenuItem)
        
        let appMenu = NSMenu()
        mainAppMenuItem.submenu = appMenu
        
        let appServicesMenu = NSMenu()
        NSApplication.shared.servicesMenu = appServicesMenu
        
        let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? ""
        
        let aboutItem = NSMenuItem(title: "About \(appName)", action: nil, keyEquivalent: "")
        let preferencesItem = NSMenuItem(title: "Preferences...", action: nil, keyEquivalent: ",")
        let hideItem = NSMenuItem(title: "Hide \(appName)", action: #selector(NSApplication.hide(_:)), keyEquivalent: "h")
        let hideOthersItem = NSMenuItem(title: "Hide Others", action: #selector(NSApplication.hideOtherApplications(_:)), keyEquivalent: "h")
        let showAllItem = NSMenuItem(title: "Show All", action: #selector(NSApplication.unhideAllApplications(_:)), keyEquivalent: "")
        let servicesItem = NSMenuItem(title: "Services", action: nil, keyEquivalent: "")
        let quitItem = NSMenuItem(title: "Quit \(appName)", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        
        hideOthersItem.keyEquivalentModifierMask = [.command, .option]
        servicesItem.submenu = appServicesMenu
        
        appMenu.addItem(aboutItem)
        appMenu.addItem(.separator())
        appMenu.addItem(preferencesItem)
        appMenu.addItem(.separator())
        appMenu.addItem(hideItem)
        appMenu.addItem(hideOthersItem)
        appMenu.addItem(showAllItem)
        appMenu.addItem(.separator())
        appMenu.addItem(servicesItem)
        appMenu.addItem(.separator())
        appMenu.addItem(quitItem)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
