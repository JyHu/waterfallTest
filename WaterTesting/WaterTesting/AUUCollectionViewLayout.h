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

- (NSInteger)currentSectionCountOfCollectionView:(UICollectionView *)collectionView;

@end

@interface AUUCollectionViewLayout : UICollectionViewLayout

@property (assign, nonatomic) id<AUUCollectionViewLayoutDelegate> layoutDelegate;

@property (assign, nonatomic) NSInteger numberOfRows;

@property (assign, nonatomic) CGFloat interval;

@property (assign, nonatomic) NSInteger fallInSection;

@property (assign, nonatomic) CGSize contentSize;

@end
