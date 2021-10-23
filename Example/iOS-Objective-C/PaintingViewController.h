//
//  PaintingViewController.h
//  iOS-Objective-C
//
//  Created by Felix Herrmann on 14.10.21.
//

#import <UIKit/UIKit.h>

@class Painting;

@interface PaintingViewController : UIViewController

- (instancetype)initWithPainting:(Painting *)painting;

@property (strong, atomic) Painting *painting;

@end
