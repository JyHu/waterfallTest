//
//  AUUCollectionViewLayout.h
//  WaterTesting
//
//  Created by 胡金友 on 15/7/2.
//  Copyright (c) 2015年 胡金友. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AUUCollectionViewLayout;

@protocol AUUCollectionViewLayoutDelegate <NSObject>

@required

- (CGSize)collectionView:(UICollectionView *)collectionView collectionViewLayout:(AUUCollectionViewLayout *)collectionViewLayout sizeOfItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface AUUCollectionViewLayout : UICollectionViewLayout

/**
 *  @author JyHu, 15-07-02 18:07:07
 *
 *  代理
 *
 *  @since  v 1.0
 */
@property (assign, nonatomic) id<AUUCollectionViewLayoutDelegate> layoutDelegate;

/**
 *  @author JyHu, 15-07-02 18:07:54
 *
 *  要显示多少列
 *
 *  @since  v 1.0
 */
@property (assign, nonatomic) NSInteger numberOfRows;

/**
 *  @author JyHu, 15-07-02 18:07:44
 *
 *  间距
 *
 *  @since  v 1.0
 */
@property (assign, nonatomic) CGFloat interval;

/**
 *  @author JyHu, 15-07-02 18:07:17
 *
 *  要做瀑布流的section
 *
 *  @since  v 1.0
 */
@property (assign, nonatomic) NSInteger fallInSection;

- (void)reloadAllData;

- (void)appendDataFromIndex:(NSInteger)index;

@end
