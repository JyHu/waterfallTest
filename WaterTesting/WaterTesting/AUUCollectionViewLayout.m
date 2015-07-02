//
//  AUUCollectionViewLayout.m
//  WaterTesting
//
//  Created by 胡金友 on 15/7/2.
//  Copyright (c) 2015年 胡金友. All rights reserved.
//

#import "AUUCollectionViewLayout.h"

@interface AUUCollectionViewLayout()

/**
 *  @author JyHu, 15-07-02 18:07:36
 *
 *  缓存每列的高度
 *
 *  @since  v 1.0
 */
@property (retain, nonatomic) NSMutableArray *p_yOriginsOfRowsArr;

/**
 *  @author JyHu, 15-07-02 18:07:24
 *
 *  每个cell的平均宽度
 *
 *  @since  v 1.0
 */
@property (assign, nonatomic) CGFloat p_itemWidth;

/**
 *  @author JyHu, 15-07-02 18:07:07
 *
 *  需要瀑布流的section有多少的cell
 *
 *  @since  v 1.0
 */
@property (assign, nonatomic) NSInteger p_cellCount;

/**
 *  @author JyHu, 15-07-02 18:07:37
 *
 *  所要计算的瀑布流的CollectionView的大小
 *
 *  @since  v 1.0
 */
@property (assign, nonatomic) CGSize p_contentSize;

@property (retain, nonatomic) NSMutableArray *p_layoutAttributes;

@property (assign, nonatomic) NSInteger p_reloadBeginIndex;

@end

@implementation AUUCollectionViewLayout

@synthesize layoutDelegate = _layoutDelegate;

@synthesize numberOfRows = _numberOfRows;

@synthesize interval = _interval;

@synthesize fallInSection = _fallInSection;

@synthesize p_contentSize = _p_contentSize;

@synthesize p_itemWidth = _p_itemWidth;

@synthesize p_yOriginsOfRowsArr = _p_yOriginsOfRowsArr;

@synthesize p_cellCount = _p_cellCount;

@synthesize p_layoutAttributes = _p_layoutAttributes;

@synthesize p_reloadBeginIndex = _p_reloadBeginIndex;


- (id)init
{
    self = [super init];
    
    if (self)
    {
        _numberOfRows = 2;
        _interval = 10;
        _p_yOriginsOfRowsArr = [[NSMutableArray alloc] init];
        _p_layoutAttributes = [[NSMutableArray alloc] init];
        _fallInSection = 0;
    }
    return self;
}

#pragma mark - UICollectionViewLayout methods

- (void)prepareLayout
{
    [super prepareLayout];
    
    _p_contentSize = self.collectionView.frame.size;
    
    _p_cellCount = [self.collectionView numberOfItemsInSection:_fallInSection];
    
    _p_itemWidth = (_p_contentSize.width - (_numberOfRows + 1) * _interval) / (_numberOfRows * 1.0);
}

- (CGSize)collectionViewContentSize
{
    CGFloat maxY;
    
    if (_p_yOriginsOfRowsArr && [_p_yOriginsOfRowsArr count] != 0)
    {
        maxY = [[_p_yOriginsOfRowsArr objectAtIndex:[self higherRowIndex]] floatValue];
    }
    
    if (maxY < _p_contentSize.height)
    {
        maxY = _p_contentSize.height + 1;
    }
    
    return CGSizeMake(_p_contentSize.width, maxY);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 逻辑需要待处理，不能每次滚动的时候都重新计算，这样会浪费内存、浪费时间。
    
    // --------------------------->
    
    NSMutableArray *attributes = [[NSMutableArray alloc] init];
    
    if (_p_yOriginsOfRowsArr)
    {
        [_p_yOriginsOfRowsArr removeAllObjects];
    }
    
    for (NSInteger i = 0; i < self.numberOfRows; i ++)
    {
        [_p_yOriginsOfRowsArr addObject:@(_interval)];
    }
    
    for (NSInteger i = 0 ; i< self.p_cellCount; i++)
    {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:self.fallInSection];
        
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexpath]];
    }
    
    return attributes;
    
    // <----------------------------
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = [self.layoutDelegate collectionView:self.collectionView collectionViewLayout:self sizeOfItemAtIndexPath:indexPath];
    
    CGFloat itemHeight = floorf(itemSize.height * self.p_itemWidth / itemSize.width);
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger row = [self shorterRowIndex];
    
    CGFloat x = _interval * (row + 1) + _p_itemWidth * row;
    
    CGFloat y = [[_p_yOriginsOfRowsArr objectAtIndex:row] floatValue];
    
    [self updateYOrigin:(y + _interval + itemHeight) inRow:row];
    
    attributes.frame = CGRectMake(x, y, _p_itemWidth, itemHeight);
    
    return attributes;
}

#pragma mark - help methods

- (NSInteger)higherRowIndex
{
    NSInteger row = 0;
    
    for (NSInteger index = 1; index < _p_yOriginsOfRowsArr.count; index ++)
    {
        CGFloat y1 = [[_p_yOriginsOfRowsArr objectAtIndex:row] floatValue];
        CGFloat y2 = [[_p_yOriginsOfRowsArr objectAtIndex:index] floatValue];
        
        if (y1 < y2)
        {
            row = index;
        }
    }
    
    return row;
}

- (NSInteger)shorterRowIndex
{
    NSInteger row = 0;
    
    for (NSInteger index = 1; index < _p_yOriginsOfRowsArr.count; index ++)
    {
        CGFloat y1 = [[_p_yOriginsOfRowsArr objectAtIndex:row] floatValue];
        CGFloat y2 = [[_p_yOriginsOfRowsArr objectAtIndex:index] floatValue];
        
        if (y1 > y2)
        {
            row = index;
        }
    }
    
    return row;
}

- (void)updateYOrigin:(CGFloat)y inRow:(NSInteger)row
{
    if (_p_yOriginsOfRowsArr && row < _p_yOriginsOfRowsArr.count)
    {
        [_p_yOriginsOfRowsArr replaceObjectAtIndex:row withObject:@(y)];
    }
}

#pragma mark - setter methods

- (void)setNumberOfRows:(NSInteger)numberOfRows
{
    _numberOfRows = (numberOfRows < 2 ? 2 : numberOfRows);
}

- (void)setInterval:(CGFloat)interval
{
    _interval = (interval < 0 ? 10 : interval);
}

- (void)setFallInSection:(NSInteger)fallInSection
{
    NSInteger secs = [self.collectionView numberOfSections];
    
    _fallInSection = ((fallInSection > 0 && fallInSection < secs) ? fallInSection : 0);
}

@end
