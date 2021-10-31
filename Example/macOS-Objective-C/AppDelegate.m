//
//  AppDelegate.m
//  macOS-Objective-C
//
//  Created by Felix Herrmann on 23.10.21.
//

#import "AppDelegate.h"
#import "ViewController.h"


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    NSRect screenRect = [NSScreen mainScreen].frame;
    NSRect contentRect = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
    
    self.window = [[NSWindow alloc] initWithContentRect:contentRect styleMask:NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable | NSWindowStyleMaskTitled | NSWindowStyleMaskUnifiedTitleAndToolbar | NSWindowStyleMaskFullSizeContentView backing:NSBackingStoreBuffered defer:NO];
    
    self.window.title = @"macOS Objective-C Example";
    self.window.contentViewController = [[ViewController alloc] init];
    [self.window makeKeyAndOrderFront:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

@end
