//
//  ViewController.m
//  macOS-Objective-C
//
//  Created by Felix Herrmann on 23.10.21.
//

#import "ViewController.h"
#import "PaintingItem.h"
#import "macOS_Objective_C-Swift.h"


@interface ViewController ()

@property NSScrollView* scrollView;
@property NSCollectionView* collectionView;

@property NSCollectionViewDiffableDataSource<NSString *,Painting *> *dataSource;

@end


@implementation ViewController


#pragma mark - ViewController

- (void)loadView {
    self.collectionView = [[NSCollectionView alloc] init];
    self.collectionView.collectionViewLayout = [self createLayout];
    [self.collectionView registerClass:PaintingItem.class forItemWithIdentifier:@"painting"];
    
    self.scrollView = [[NSScrollView alloc] initWithFrame:CGRectMake(0, 0, 800, 630)];
    self.scrollView.documentView = self.collectionView;
    self.view = self.scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureDataSource];
    [self applySnapshot];
}


#pragma mark - CollectionViewLayout

- (NSCollectionViewLayout *)createLayout {
    NSCollectionViewCompositionalLayout *layout = [[NSCollectionViewCompositionalLayout alloc] initWithSectionProvider:^NSCollectionLayoutSection * _Nullable(NSInteger _, id<NSCollectionLayoutEnvironment> _Nonnull environment) {
        CGFloat itemsPerWidth = (CGFloat)(int)(environment.container.effectiveContentSize.width / 300);
        CGFloat fractionalWidth = 1 / (itemsPerWidth < 1 ? 1 : itemsPerWidth);
        NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:fractionalWidth] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1]];
        NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
        NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1]  heightDimension:[NSCollectionLayoutDimension absoluteDimension:100]];
        NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitems:@[item]];
        NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
        return section;
    }];
    return layout;
}


#pragma mark - DiffableDataSource

- (void)configureDataSource {
    self.dataSource = [[NSCollectionViewDiffableDataSource alloc] initWithCollectionView:self.collectionView itemProvider:^NSCollectionViewItem * _Nullable(NSCollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, Painting * _Nonnull painting) {
        PaintingItem *item = [collectionView makeItemWithIdentifier:@"painting" forIndexPath:indexPath];
        item.image = painting.image;
        item.mainLabel.text = painting.name;
        item.secondaryLabel.text = painting.artist;
        item.detailLabel.text = [NSString stringWithFormat:@"• %zd", painting.year];
        return item;
    }];
}

- (void)applySnapshot {
    NSDiffableDataSourceSnapshot<NSString *,Painting *> *snapshot = [[NSDiffableDataSourceSnapshot alloc] init];
    [snapshot appendSectionsWithIdentifiers:@[@"main"]];
    [snapshot appendItemsWithIdentifiers:Painting.examples intoSectionWithIdentifier:@"main"];
    [self.dataSource applySnapshot:snapshot animatingDifferences:NO];
}

@end
