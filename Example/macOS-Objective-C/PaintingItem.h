//
//  PaintingItem.h
//  macOS-Objective-C
//
//  Created by Felix Herrmann on 23.10.21.
//

#import <AppKit/AppKit.h>
#import "NSLabel.h"

@interface PaintingItem : NSCollectionViewItem

@property NSLabel *mainLabel;
@property NSLabel *secondaryLabel;
@property NSLabel *detailLabel;

@property (nonatomic) NSImage *image;

@end
