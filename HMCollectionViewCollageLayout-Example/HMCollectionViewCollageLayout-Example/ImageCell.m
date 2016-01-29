//
//  ImageCell.m
//  HMCollectionViewCollageLayout-Example
//
//  Created by Antal Norbert on 1/29/16.
//  Copyright (c) 2016 Antal Norbert. All rights reserved.
//

#import "ImageCell.h"
#import "UIImageView+WebCache.h"

#pragma mark - Class Extension -

@interface ImageCell ()
@property (nonatomic) UIImageView *imageView;
@end

#pragma mark - Implementation -

@implementation ImageCell

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil;
}

#pragma mark - UI

- (void)initView {
    self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imageView];
}

#pragma mark - Setter/Getter

- (void)setImageUrl:(NSURL *)imageUrl {
    [self.imageView sd_setImageWithURL:imageUrl];
}

@end
