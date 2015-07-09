//
//  AUUCollectionFlowIndexPath.h
//  WaterTesting
//
//  Created by 胡金友 on 15/7/9.
//  Copyright (c) 2015年 胡金友. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AUUCollectionFlowIndexPath : NSObject

@property (assign, nonatomic) NSInteger section;

@property (assign, nonatomic) NSInteger row;

@property (assign, nonatomic) CGFloat rowHeight;

- (id)initWithHeight:(CGFloat)height;

@end
