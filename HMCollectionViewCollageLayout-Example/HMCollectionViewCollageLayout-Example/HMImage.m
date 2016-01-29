//
//  HMImage.m
//  HMCollectionViewCollageLayout-Example
//
//  Created by Antal Norbert on 1/29/16.
//  Copyright (c) 2016 Antal Norbert. All rights reserved.
//

#import "HMImage.h"

@implementation HMImage

+ (instancetype)imageWithUrl:(NSURL *)url aspect:(CGFloat)aspect {
    HMImage *instance = [HMImage new];
    instance.imageUrl = url;
    instance.aspect = aspect;
    return instance;
}

#pragma mark - HMCollageImage protocol

- (CGFloat)aspectRatio {
    return self.aspect;
}

@end
