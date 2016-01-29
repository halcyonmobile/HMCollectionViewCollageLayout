//
//  HMCollectionViewCollageLayoutDataSource.h
//  HMCollectionViewCollageLayout
//
//  Created by Antal Norbert on 1/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

@protocol HMCollectionViewCollageLayoutDataSource <NSObject>
@required
- (CGSize)contentSize;
- (NSInteger)numberOfRows;
- (CGRect)frameForImageAtIndex:(NSUInteger)index;
- (void)refreshLayoutForCollectionViewSize:(CGSize)size;

@end
