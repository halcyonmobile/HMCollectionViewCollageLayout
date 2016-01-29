//
//  ViewController.m
//  HMCollectionViewCollageLayout-Example
//
//  Created by Antal Norbert on 1/29/16.
//  Copyright © 2016 Antal Norbert. All rights reserved.
//

#import "ViewController.h"
#import "HMCollectionViewCollageLayout.h"
#import "HMCollageLayoutProvider.h"
#import "HMImage.h"
#import "ImageCell.h"

static NSString * const kCellReuseIndetifier    = @"collage.layout.cell";

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) HMCollageLayoutProvider *layoutDataProvider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self.collectionView.collectionViewLayout invalidateLayout];
    }];
}

- (void)initView {
    self.layoutDataProvider = [[HMCollageLayoutProvider alloc] initWithImages:self.testImages idealRowHeight:110];
    HMCollectionViewCollageLayout *collageLayout = [HMCollectionViewCollageLayout new];
    collageLayout.layoutDataProvider = self.layoutDataProvider;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collageLayout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:kCellReuseIndetifier];
}

#pragma mark - CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.layoutDataProvider.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIndetifier forIndexPath:indexPath];
    HMImage *image = [self.layoutDataProvider.images objectAtIndex:indexPath.item];
    [cell setImageUrl:image.imageUrl];
    return cell;
}

#pragma mark - Test data

- (NSArray<HMImage *> *)testImages {
    return @[
             [HMImage imageWithUrl:[NSURL URLWithString:@"http://tophdimgs.com/data_images/wallpapers/23/406300-landscapes.jpg"] aspect:1.77],
             [HMImage imageWithUrl:[NSURL URLWithString:@"http://www.barrymellorphotography.co.uk/assets/Uploads/landscapes-13.jpg"] aspect:2.27],
             [HMImage imageWithUrl:[NSURL URLWithString:@"http://ayay.co.uk/backgrounds/nature/sunrises_and_sunsets/Landscapes-Sunset-over-the-Lake-in-the-Mountans.jpg"] aspect:1.33],
             [HMImage imageWithUrl:[NSURL URLWithString:@"http://www.growproaustralia.com/wp-content/uploads/2014/08/header-atn-01.jpg"] aspect:1.83],
             [HMImage imageWithUrl:[NSURL URLWithString:@"http://theplanetd.com/images/south-australia-landscapes-2.jpg"] aspect:1.49]
             ];
}

@end
