//
//  HMImage.h
//  HMCollectionViewCollageLayout-Example
//
//  Created by Antal Norbert on 1/29/16.
//  Copyright (c) 2016 Antal Norbert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMCollageImageProtocol.h"

@interface HMImage : NSObject <HMCollageImageProtocol>

@property (nonatomic) NSURL *imageUrl;
@property (nonatomic) CGFloat aspect;

+ (instancetype)imageWithUrl:(NSURL *)url aspect:(CGFloat)aspect;

@end
