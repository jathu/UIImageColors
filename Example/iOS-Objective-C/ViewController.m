//
//  ViewController.m
//  iOS-Objective-C
//
//  Created by Felix Herrmann on 14.10.21.
//

#import "ViewController.h"
#import "iOS_Objective_C-Swift.h"
#import "PaintingViewController.h"
@import UIImageColorsObjc;


@interface UIPageViewController ()

@property UIPageControl *_pageControl; // expose internal property

@end


@interface ViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong) UILabel *mainLabel;
@property (strong) UILabel *secondaryLabel;
@property (strong) UILabel *detailLabel;

@property (strong) UIPageViewController *pageViewController;

@property (nonatomic) NSInteger currentIndex;

@end


@implementation ViewController


#pragma mark - Setter

- (void)setCurrentIndex:(NSInteger)currentIndex {
    if(currentIndex < 0) {
        _currentIndex = Painting.examples.count - 1;
    } else if (currentIndex > Painting.examples.count - 1) {
        _currentIndex = 0;
    } else {
        _currentIndex = currentIndex;
    }
}


#pragma mark - ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLabels];
    [self setupPageViewController];
}


#pragma mark - Setup

- (void)setupLabels {
    self.mainLabel = [[UILabel alloc] init];
    self.mainLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.mainLabel.numberOfLines = 2;
    self.mainLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightRegular];
    
    self.secondaryLabel = [[UILabel alloc] init];
    self.secondaryLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.secondaryLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.detailLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    
    [self.view addSubview:self.mainLabel];
    [self.view addSubview:self.secondaryLabel];
    [self.view addSubview:self.detailLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.mainLabel.leadingAnchor constraintEqualToAnchor:self.view.readableContentGuide.leadingAnchor constant:20],
        [self.mainLabel.topAnchor constraintEqualToAnchor:self.view.readableContentGuide.topAnchor constant:72],
        [self.mainLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.readableContentGuide.trailingAnchor constant:-20],
        
        [self.secondaryLabel.leadingAnchor constraintEqualToAnchor: self.view.readableContentGuide.leadingAnchor constant: 20],
        [self.secondaryLabel.trailingAnchor constraintLessThanOrEqualToAnchor: self.view.readableContentGuide.trailingAnchor constant: -20],
        [self.secondaryLabel.bottomAnchor constraintEqualToAnchor: self.detailLabel.topAnchor  constant: -4],
        
        [self.detailLabel.leadingAnchor constraintEqualToAnchor: self.view.readableContentGuide.leadingAnchor constant: 20],
        [self.detailLabel.trailingAnchor constraintLessThanOrEqualToAnchor: self.view.readableContentGuide.trailingAnchor constant: -20],
        [self.detailLabel.bottomAnchor constraintEqualToAnchor: self.view.readableContentGuide.bottomAnchor constant: -92]
    ]];
}

- (void)setupPageViewController {
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    PaintingViewController *firstPaitingViewController = [[PaintingViewController alloc] initWithPainting:Painting.examples[self.currentIndex]];
    [self.pageViewController setViewControllers:@[firstPaitingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    [self updateColorsFrom:firstPaitingViewController];
    
    [self addChildViewController:self.pageViewController];
    [self.pageViewController didMoveToParentViewController:self];
    [self.view addSubview:self.pageViewController.view];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.pageViewController.view.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [self.pageViewController.view.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [self.pageViewController.view.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
        [self.pageViewController.view.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor]
    ]];
}


#pragma mark - Methods

- (void)updateColorsFrom:(PaintingViewController *)paintingViewController {
    [paintingViewController.painting.image getColorsWithQuality:UIImageColorsScaleQualityHigh completion:^(UIImageColors * _Nullable colors) {
        [UIView animateWithDuration:0.15 animations:^{
            self.view.backgroundColor = colors.background;
            
            self.mainLabel.text = paintingViewController.painting.name;
            self.mainLabel.textColor = colors.primary;
            
            self.secondaryLabel.text = paintingViewController.painting.artist;
            self.secondaryLabel.textColor = colors.secondary;
            
            self.detailLabel.text = [NSString stringWithFormat:@"%ld", paintingViewController.painting.year];
            self.detailLabel.textColor = colors.detail;
            
            self.pageViewController._pageControl.currentPageIndicatorTintColor = colors.primary;
            self.pageViewController._pageControl.pageIndicatorTintColor = colors.secondary;
        }];
    }];
}


#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    PaintingViewController *paintingViewController = (PaintingViewController *)viewController;
    NSUInteger index = [Painting.examples indexOfObject:paintingViewController.painting];
    self.currentIndex = index - 1;
    return [[PaintingViewController alloc] initWithPainting:Painting.examples[self.currentIndex]];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    PaintingViewController *paintingViewController = (PaintingViewController *)viewController;
    NSUInteger index = [Painting.examples indexOfObject:paintingViewController.painting];
    self.currentIndex = index + 1;
    return [[PaintingViewController alloc] initWithPainting:Painting.examples[self.currentIndex]];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return Painting.examples.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return self.currentIndex;
}


#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    PaintingViewController *paintingViewController = (PaintingViewController *)pageViewController.viewControllers.firstObject;
    [self updateColorsFrom:paintingViewController];
}

@end
