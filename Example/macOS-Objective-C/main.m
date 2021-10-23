//
//  main.m
//  macOS-Objective-C
//
//  Created by Felix Herrmann on 23.10.21.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        AppDelegate *delegate = [[AppDelegate alloc] init];
        [NSApplication sharedApplication].delegate = delegate;
        [[NSApplication sharedApplication] run];
    }
    return NSApplicationMain(argc, argv);
}
