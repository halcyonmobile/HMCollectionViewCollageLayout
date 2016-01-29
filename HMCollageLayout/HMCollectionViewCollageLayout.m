//
//  HMCollectionViewCollageLayout.m
//  HMCollectionViewCollageLayout
//
//  Created by Antal Norbert on 1/19/16.
//  Copyright (c) 2016 Halcyon Mobile. All rights reserved.
//

#import "HMCollectionViewCollageLayout.h"

#pragma mark - Implementation -

@implementation HMCollectionViewCollageLayout

- (CGSize)collectionViewContentSize {
    return [self.layoutDataProvider contentSize];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray* array = [NSMutableArray array];
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger index = 0; index < itemsCount; index++ ) {
        UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        if( CGRectIntersectsRect( attributes.frame, rect) )
            [array addObject:attributes];
    }
    
    return [NSArray arrayWithArray:array];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect frame = [self.layoutDataProvider frameForImageAtIndex:(NSUInteger)indexPath.item];
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = frame;
    
    return attributes;
}

- (UICollectionViewScrollDirection)scrollDirection {
    return UICollectionViewScrollDirectionVertical;
}

- (void)invalidateLayout {
    [self.layoutDataProvider refreshLayoutForCollectionViewSize:self.collectionView.bounds.size];
    [super invalidateLayout];
}

@end
