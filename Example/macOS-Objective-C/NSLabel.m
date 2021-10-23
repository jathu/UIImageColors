//
//  NSLabel.m
//  macOS-Objective-C
//
//  Created by Felix Herrmann on 23.10.21.
//

#import "NSLabel.h"


@implementation NSLabel


#pragma mark - Properties

- (NSString *)text {
    return [self stringValue];
}

- (void)setText:(NSString *)text {
    [self setStringValue:text];
}


#pragma mark - Initializers

- (instancetype)initWithFrame:(NSRect)frameRect {
    if(self = [super initWithFrame:frameRect]) {
        [self setLineBreakMode:NSLineBreakByTruncatingTail];
        [self setMaximumNumberOfLines:1];
        [self setBezeled:false];
        [self setDrawsBackground:false];
        [self setEditable:false];
        [self setSelectable:false];
    }
    
    return self;
}

@end
