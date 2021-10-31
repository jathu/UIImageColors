//
//  PaintingViewController.m
//  iOS-Objective-C
//
//  Created by Felix Herrmann on 14.10.21.
//

#import "PaintingViewController.h"
#import "iOS_Objective_C-Swift.h"


@interface PaintingViewController ()

@property UIImageView *imageView;

@end


@implementation PaintingViewController


#pragma mark - Initializers

- (instancetype)initWithPainting:(Painting *)painting {
    if(self = [super init]) {
        self.painting = painting;
    }
    
    return self;
}


#pragma mark - ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}


#pragma mark - Setup

- (void)setupView {
    self.imageView = [[UIImageView alloc] initWithImage:self.painting.image];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.imageView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.view.readableContentGuide.leadingAnchor constant:20],
        [self.imageView.topAnchor constraintEqualToAnchor:self.view.readableContentGuide.topAnchor constant:160],
        [self.imageView.trailingAnchor constraintEqualToAnchor:self.view.readableContentGuide.trailingAnchor constant:-20],
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.view.readableContentGuide.bottomAnchor constant:-140]
    ]];
}

@end
