//
//  MyCollectionViewLayout.h
//  WaterTesting
//
//  Created by 胡金友 on 15/7/2.
//  Copyright (c) 2015年 胡金友. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@class MyCollectionViewLayout;

@protocol MyCollectionViewLayoutDelegate <NSObject>

@required

- (CGSize)collectionView:(UICollectionView *)collectionView collectionViewLayout:(MyCollectionViewLayout *)collectionViewLayout sizeOfItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MyCollectionViewLayout : UICollectionViewLayout

@property (assign, nonatomic) id<MyCollectionViewLayoutDelegate> layoutDelegate;

@end
