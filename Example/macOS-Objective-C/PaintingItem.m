//
//  PaintingItem.m
//  macOS-Objective-C
//
//  Created by Felix Herrmann on 23.10.21.
//

#import "PaintingItem.h"
@import UIImageColorsObjc;


@interface PaintingItem ()

@property NSView *_imageView;

@end


@implementation PaintingItem


#pragma mark - Setter

- (void)setImage:(NSImage *)image {
    [self._imageView.layer setContents:image];
    [image getColorsWithQuality:UIImageColorsScaleQualityHigh completion:^(NSImageColors * _Nullable colors) {
        if(colors != nil) {
            [self.view.layer setBackgroundColor:colors.background.CGColor];
            [self.mainLabel setTextColor:colors.primary];
            [self.secondaryLabel setTextColor:colors.secondary];
            [self.detailLabel setTextColor:colors.detail];
        } else {
            [self.view.layer setBackgroundColor:nil];
            [self.mainLabel setTextColor:NSColor.labelColor];
            [self.secondaryLabel setTextColor:NSColor.labelColor];
            [self.detailLabel setTextColor:NSColor.labelColor];
        }
    }];
}


#pragma mark - ViewController

- (void)loadView {
    self.view = [[NSView alloc] init];
    [self.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [self.view setWantsLayer:true];
    
    self._imageView = [[NSView alloc] init];
    [self._imageView setLayer:[[CALayer alloc] init]];
    [self._imageView.layer setContentsGravity:kCAGravityResizeAspectFill];
    [self._imageView setTranslatesAutoresizingMaskIntoConstraints:false];
    
    self.mainLabel = [[NSLabel alloc] init];
    [self.mainLabel setFont:[NSFont systemFontOfSize:15 weight:NSFontWeightSemibold]];
    [self.mainLabel setTranslatesAutoresizingMaskIntoConstraints:false];
    
    self.secondaryLabel = [[NSLabel alloc] init];
    [self.secondaryLabel setFont:[NSFont systemFontOfSize:12 weight:NSFontWeightSemibold]];
    [self.secondaryLabel setTranslatesAutoresizingMaskIntoConstraints:false];
    
    self.detailLabel = [[NSLabel alloc] init];
    [self.detailLabel setFont:[NSFont systemFontOfSize:12 weight:NSFontWeightSemibold]];
    [self.detailLabel setTranslatesAutoresizingMaskIntoConstraints:false];
    
    NSLayoutGuide *layoutGuide = [[NSLayoutGuide alloc] init];
    [self.view addLayoutGuide:layoutGuide];
    
    [self.view addSubview:self._imageView];
    [self.view addSubview:self.mainLabel];
    [self.view addSubview:self.secondaryLabel];
    [self.view addSubview:self.detailLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [layoutGuide.leadingAnchor constraintEqualToAnchor:self._imageView.trailingAnchor constant:20],
        [layoutGuide.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.trailingAnchor constant:-20],
        [layoutGuide.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        
        [self._imageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self._imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self._imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self._imageView.widthAnchor constraintEqualToAnchor:self._imageView.heightAnchor],
        
        [self.mainLabel.leadingAnchor constraintEqualToAnchor:layoutGuide.leadingAnchor],
        [self.mainLabel.topAnchor constraintEqualToAnchor:layoutGuide.topAnchor],
        [self.mainLabel.trailingAnchor constraintLessThanOrEqualToAnchor:layoutGuide.trailingAnchor],
        
        [self.secondaryLabel.leadingAnchor constraintEqualToAnchor: layoutGuide.leadingAnchor],
        [self.secondaryLabel.topAnchor constraintEqualToAnchor: self.mainLabel.bottomAnchor constant:4],
        [self.secondaryLabel.bottomAnchor constraintEqualToAnchor: layoutGuide.bottomAnchor],
        
        [self.detailLabel.leadingAnchor constraintEqualToAnchor: self.secondaryLabel.trailingAnchor constant: 4],
        [self.detailLabel.firstBaselineAnchor constraintEqualToAnchor: self.secondaryLabel.firstBaselineAnchor],
        [self.detailLabel.trailingAnchor constraintLessThanOrEqualToAnchor: layoutGuide.trailingAnchor]
    ]];
}

@end
