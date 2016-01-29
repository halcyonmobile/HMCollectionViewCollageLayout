//
//  HMCollageLayoutProvider.h
//  HMCollectionViewCollageLayout
//
//  Created by Antal Norbert on 1/19/16.
//  Copyright (c) 2016 Halcyon Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "HMCollectionViewCollageLayoutDataSource.h"
#import "HMCollageImageProtocol.h"

@interface HMCollageLayoutProvider : NSObject <HMCollectionViewCollageLayoutDataSource>

@property (nonatomic) NSArray<id<HMCollageImageProtocol>> *images;

- (instancetype)initWithImages:(NSArray<id<HMCollageImageProtocol>> *)images idealRowHeight:(CGFloat)idealHeight;

@end
