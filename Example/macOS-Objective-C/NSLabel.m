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
        self.lineBreakMode = NSLineBreakByTruncatingTail;
        self.maximumNumberOfLines = 1;
        self.bezeled = NO;
        self.drawsBackground = NO;
        self.editable = NO;
        self.selectable = NO;
    }
    
    return self;
}

@end
