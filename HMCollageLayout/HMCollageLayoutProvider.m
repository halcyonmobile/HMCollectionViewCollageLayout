//
//  CollageLayoutProvider.m
//  Konversed
//
//  Created by Antal Norbert on 1/19/16.
//  Copyright (c) 2016 Halcyon Mobile. All rights reserved.
//

#import "HMCollageLayoutProvider.h"

static CGFloat const kDefaultIdealRowHeight     = 150.0;
static CGFloat const kDefaultSeparatorWidth     = 1.0;

@interface HMCollageLayoutProvider ()

@property (nonatomic) CGFloat idealRowHeight;
@property (nonatomic) CGFloat width;

@property (nonatomic) NSMutableArray *imageLayouts;
@property (nonatomic) NSInteger totalRows;
@property (nonatomic) CGFloat verticalOffset;

@end

@implementation HMCollageLayoutProvider

#pragma mark - Init methods

- (instancetype)init {
    return [self initWithImages:nil idealRowHeight:kDefaultIdealRowHeight];
}

- (instancetype)initWithImages:(NSArray<id<HMCollageImageProtocol>> *)images idealRowHeight:(CGFloat)idealHeight {
    self = [super init];
    if (self) {
        _imageLayouts = [NSMutableArray array];
        _idealRowHeight = idealHeight;
        _images = images;
        _width = 320.0;
        
        [self calculateLayoutForImages:images];
    }
    return self;
}

#pragma mark - Setters/Getters

- (void)setImages:(NSArray<id<HMCollageImageProtocol>> *)images {
    _images = images;
    
    [self refreshLayout];
}

#pragma mark - Logic

- (void)refreshLayout {
    self.totalRows = 0;
    self.verticalOffset = 0.0;
    [self.imageLayouts removeAllObjects];
    
    [self calculateLayoutForImages:self.images];
}

- (void)calculateLayoutForImages:(NSArray<NSObject<HMCollageImageProtocol> *> *)images {
    if (!images || (images.count == 0)) {
        return;
    }
    
    CGFloat totalWidth = 0.0;
    for (NSObject *imageObj in images) {
        NSObject<HMCollageImageProtocol> *image = (id<HMCollageImageProtocol>)imageObj;
        totalWidth += ceil(image.aspectRatio * self.idealRowHeight);
    }
    
    CGFloat verticalOffset = 0.0;
    NSInteger rows = (NSInteger)(totalWidth / self.width);
    if (rows < 1) {
        /* There is a single row */
        verticalOffset = [self buildRowWithImages:images verticalOffset:0.0 rowWidth:totalWidth];
    } else {
        /* Multiple rows */
        NSUInteger index = 0;
        CGFloat rowWidth = 0.0;
        NSMutableArray *rowItems = [NSMutableArray array];
        
        while (index < images.count) {
            id<HMCollageImageProtocol> image = (id<HMCollageImageProtocol>)[images objectAtIndex:index];
            CGFloat imageWidth = ceil(image.aspectRatio * self.idealRowHeight);
            
            if ((rowWidth + imageWidth) < self.width) {
                rowWidth += imageWidth;
                [rowItems addObject:image];
            } else {
                CGFloat rowHeight = [self buildRowWithImages:rowItems verticalOffset:verticalOffset rowWidth:rowWidth];
                verticalOffset += (rowHeight + kDefaultSeparatorWidth);

                rowWidth = imageWidth;
                [rowItems removeAllObjects];
                [rowItems addObject:image];
            }
            
            index++;
        }
        
        if (rowItems.count > 0) {
            CGFloat rowHeight = [self buildRowWithImages:rowItems verticalOffset:verticalOffset rowWidth:rowWidth];
            verticalOffset += (rowHeight + kDefaultSeparatorWidth);
        }
    }
    
    self.verticalOffset = verticalOffset;
    self.totalRows = rows;
    
}

- (CGFloat)buildRowWithImages:(NSArray<id<HMCollageImageProtocol>> *)images verticalOffset:(CGFloat)verticalOffset rowWidth:(CGFloat)rowWidth {
    CGFloat lastHorizontalOffset = 0.0;
    CGFloat scaleFactor = self.width / rowWidth;
    CGFloat rowHeight = self.idealRowHeight * scaleFactor;
    
    for (id<HMCollageImageProtocol> image in images) {
        CGRect frame = CGRectMake(lastHorizontalOffset, verticalOffset, rowHeight * image.aspectRatio, rowHeight);
        lastHorizontalOffset = CGRectGetMaxX(frame) + kDefaultSeparatorWidth;
        [self.imageLayouts addObject:[NSValue valueWithCGRect:frame]];
    }
    
    return rowHeight;
}

#pragma mark - Collage layout protocol

- (CGRect)frameForImageAtIndex:(NSUInteger)index {
    return [(NSValue *)[self.imageLayouts objectAtIndex:index] CGRectValue];
}

- (CGSize)contentSize {
    return CGSizeMake(self.width, self.verticalOffset);
}

- (NSInteger)numberOfRows {
    return self.totalRows;
}

- (void)refreshLayoutForCollectionViewSize:(CGSize)size {
    self.width = size.width;
    [self refreshLayout];
}

@end
