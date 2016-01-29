//
//  HMCollectionViewCollageLayout.h
//  HMCollectionViewCollageLayout
//
//  Created by Antal Norbert on 1/19/16.
//  Copyright (c) 2016 Halcyon Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCollectionViewCollageLayoutDataSource.h"

@interface HMCollectionViewCollageLayout : UICollectionViewLayout

@property (nonatomic, weak) id<HMCollectionViewCollageLayoutDataSource> layoutDataProvider;

@end
