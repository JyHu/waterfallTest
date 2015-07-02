//
//  MyCollectionViewLayout.m
//  WaterTesting
//
//  Created by 胡金友 on 15/7/2.
//  Copyright (c) 2015年 胡金友. All rights reserved.
//

#import "MyCollectionViewLayout.h"

@interface MyCollectionViewLayout()

@property (assign, nonatomic) CGFloat leftY;        //  左侧起始Y轴
@property (assign, nonatomic) CGFloat rightY;       //  右侧起始Y轴
@property (assign, nonatomic) NSInteger cellCount;  //  cell的个数
@property (assign, nonatomic) CGFloat itemWidth;    //  cell宽度
@property (assign, nonatomic) CGFloat insert;       //  间距

@end

@implementation MyCollectionViewLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    // 初始化
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    _insert = 10;   //  设置间距
    _itemWidth = (SCREEN_WIDTH  - 3 * _insert) / 2.0;    // cell宽度
    
}

/**
 *  @author JyHu, 15-07-02 11:07:18
 *
 *  设置UICollectionView的内容大小，道理与UIScrollView的contentSize类似
 *
 *  @return 返回设置的UICollectionView的内容大小
 */
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(SCREEN_WIDTH, MAX(_leftY, _rightY));
}

/**
 *  @author JyHu, 15-07-02 12:07:14
 *
 *  初始化layout外观
 *
 *  @param rect 所有元素的布局属性
 *
 *  @return 所有元素的布局
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    _leftY = _insert;   //  左边起始Y轴
    _rightY = _insert;  //  右边起始Y轴
    
    NSMutableArray *attributes = [[NSMutableArray alloc] init];
    
    for (NSInteger i=0; i<self.cellCount; i++)
    {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexpath]];
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  @author JyHu, 15-07-02 12:07:01
     *
     *  获取代理中返回的每一个cell的大小
     */
    CGSize itemSize = [self.layoutDelegate collectionView:self.collectionView collectionViewLayout:self sizeOfItemAtIndexPath:indexPath];
    
    //防止代理中给的size.width大于（或小于）layout中定义的width，所以等比例缩放size
    CGFloat itemHeight = floorf(itemSize.height * self.itemWidth / itemSize.width);
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
//    attributes.transform3D = CATransform3DMakeRotation(M_PI_4, 1, 1, 1);;
    
    /**
     *  @author JyHu, 15-07-02 12:07:43
     *
     *  判断当前的item应该在左侧还是在右侧
     */
    BOOL isLeft = _leftY < _rightY;
    
    if (isLeft)
    {
        CGFloat x = _insert;    //  设置新的Y起点
        attributes.frame = CGRectMake(x, _leftY, _itemWidth, itemHeight);
        _leftY += itemHeight + _insert;    // 设置新的Y起点
    }
    
    if (!isLeft)
    {
        CGFloat x = _itemWidth + 2 * _insert;
        attributes.frame = CGRectMake(x, _rightY, _itemWidth, itemHeight);
        _rightY += itemHeight + _insert;
    }
    
    return attributes;
}

@end
