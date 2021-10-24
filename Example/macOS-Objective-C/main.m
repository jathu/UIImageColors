//
//  main.m
//  macOS-Objective-C
//
//  Created by Felix Herrmann on 23.10.21.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"
#import "MainMenu.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        AppDelegate *delegate = [[AppDelegate alloc] init];
        NSApplication.sharedApplication.delegate = delegate;
        
        MainMenu *mainMenu = [[MainMenu alloc] init];
        NSApplication.sharedApplication.mainMenu = mainMenu;
        
        [NSApplication.sharedApplication run];
    }
    return NSApplicationMain(argc, argv);
}
