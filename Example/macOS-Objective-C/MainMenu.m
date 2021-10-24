//
//  MainMenu.m
//  macOS-Objective-C
//
//  Created by Felix Herrmann on 24.10.21.
//

#import "MainMenu.h"

@implementation MainMenu

- (instancetype)initWithTitle:(NSString *)title {
    if(self = [super initWithTitle:title]) {
        
        NSMenuItem *mainAppMenuItem = [[NSMenuItem alloc] initWithTitle:@"Main" action:nil keyEquivalent:@""];
        [self addItem:mainAppMenuItem];
        
        NSMenu *appMenu = [[NSMenu alloc] init];
        mainAppMenuItem.submenu = appMenu;
        
        NSMenu *appServicesMenu = [[NSMenu alloc] init];
        NSApplication.sharedApplication.servicesMenu = appServicesMenu;
        
        NSString *appName = [NSBundle.mainBundle.infoDictionary valueForKey:(NSString *)kCFBundleNameKey];
        
        NSMenuItem *aboutItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"About %@", appName] action:nil keyEquivalent:@""];
        NSMenuItem *preferencesItem = [[NSMenuItem alloc] initWithTitle:@"Preferences..." action:nil keyEquivalent:@""];
        NSMenuItem *hideItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Hide %@", appName] action:@selector(hide:) keyEquivalent:@"h"];
        NSMenuItem *hideOthersItem = [[NSMenuItem alloc] initWithTitle:@"Hide Others" action:@selector(hideOtherApplications:) keyEquivalent:@"h"];
        NSMenuItem *showAllItem = [[NSMenuItem alloc] initWithTitle:@"Show All" action:@selector(unhideAllApplications:) keyEquivalent:@""];
        NSMenuItem *servicesItem = [[NSMenuItem alloc] initWithTitle:@"Services" action:nil keyEquivalent:@""];
        NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Quit %@", appName] action:@selector(terminate:) keyEquivalent:@"q"];
        
        hideOthersItem.keyEquivalentModifierMask = NSEventModifierFlagCommand | NSEventModifierFlagOption;
        servicesItem.submenu = appServicesMenu;
        
        [appMenu addItem:aboutItem];
        [appMenu addItem:NSMenuItem.separatorItem];
        [appMenu addItem:preferencesItem];
        [appMenu addItem:NSMenuItem.separatorItem];
        [appMenu addItem:hideItem];
        [appMenu addItem:hideOthersItem];
        [appMenu addItem:showAllItem];
        [appMenu addItem:NSMenuItem.separatorItem];
        [appMenu addItem:servicesItem];
        [appMenu addItem:NSMenuItem.separatorItem];
        [appMenu addItem:quitItem];
    }
    
    return self;
}

@end
