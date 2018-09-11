//
//  TZLCollectionViewWaterfallLayout.m
//  Demos
//
//  Created by tang on 2018/9/11.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLCollectionViewWaterfallLayout.h"
@interface TZLCollectionViewWaterfallLayout()
/** 保存 UICollectionViewLayoutAttributes 的数组*/
@property(nonatomic, strong) NSMutableArray *attributeses;
/** 保存上次一行每列的item的高度 */
@property(nonatomic, strong) NSMutableArray *lastLineColumnItemRect;
@end

@implementation TZLCollectionViewWaterfallLayout

static CGFloat TZLFloorCGFloat(CGFloat value) {
    CGFloat scale = [UIScreen mainScreen].scale;
    return floor(value * scale) / scale;
}

- (instancetype)init {
    if (self = [super init]) {
        self.column = 2;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.lineSpacing = 10;
        self.columnSpacing = 10;
    }
    return self;
}
- (void)prepareLayout {
    [super prepareLayout];
    NSInteger section = [self.collectionView numberOfSections];
    if (!section) {
        return;
    }
    for (NSInteger i = 0; i < section; i++) {
        NSInteger row = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j < row; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attributeses addObject:attributes];
        }
    }
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat viewWidth = self.collectionView.frame.size.width;
    CGFloat itemWidth = (viewWidth - self.sectionInset.left - self.sectionInset.right - self.columnSpacing * (self.column - 1)) / self.column;
    itemWidth = TZLFloorCGFloat(itemWidth);
    
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    
    NSInteger i = indexPath.row % self.column;
    CGRect lastItemRect = CGRectFromString(self.lastLineColumnItemRect[i]);
    X = self.sectionInset.left + i * (self.columnSpacing + itemWidth);
    Y = lastItemRect.origin.y + lastItemRect.size.height + (indexPath.row < self.column ? 0: self.lineSpacing);
    width = itemWidth;
    NSInteger radnum = arc4random_uniform(2);
    height = width * 1.5 + radnum * 30;
    self.lastLineColumnItemRect[i] = NSStringFromCGRect(CGRectMake(X, Y, width, height));
    attributes.frame = CGRectMake(X, Y, width, height);

    return attributes;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray * array = [NSMutableArray array];
    //可视rect
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    [self.attributeses enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectIntersectsRect(rect, obj.frame)) {
            [array addObject:obj];
        }
    }];
    
    return array;
}
- (CGSize)collectionViewContentSize {
    
    // 判断最高的一列
    CGFloat longest = 0;
    for (NSInteger i = 0; i < self.lastLineColumnItemRect.count; i++) {
        CGRect lastItemRect = CGRectFromString(self.lastLineColumnItemRect[i]);
        CGFloat temp = lastItemRect.origin.y + lastItemRect.size.height;
        if (temp > longest) {
            longest = temp;
        }
    }
    
    return CGSizeMake(self.collectionView.frame.size.width, longest + self.sectionInset.bottom);
}

- (NSMutableArray *)attributeses {
    if (!_attributeses) {
        _attributeses = [NSMutableArray new];
    }
    return _attributeses;
}
- (NSMutableArray *)lastLineColumnItemRect {
    if (!_lastLineColumnItemRect) {
        _lastLineColumnItemRect = [NSMutableArray arrayWithCapacity:self.column];
        for (NSInteger i = 0; i < self.column; i++) {
            [_lastLineColumnItemRect addObject:NSStringFromCGRect(CGRectMake(self.sectionInset.left, self.sectionInset.top, 0, 0))];
        }
    }
    return _lastLineColumnItemRect;
}
@end
