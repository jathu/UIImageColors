//
//  AppDelegate.swift
//  UIImageColorsExample
//
//  Created by Jathu Satkunarajah on 2017-11-30 - Toronto
//  Copyright © 2017 Jathu Satkunarajah. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Hide the status bar
        UIApplication.shared.isStatusBarHidden = true
        
        // Override storyboard
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = ViewController()
        
        return true
    }


}

