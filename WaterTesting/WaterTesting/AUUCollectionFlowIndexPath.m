//
//  AUUCollectionFlowIndexPath.m
//  WaterTesting
//
//  Created by 胡金友 on 15/7/9.
//  Copyright (c) 2015年 胡金友. All rights reserved.
//

#import "AUUCollectionFlowIndexPath.h"

@implementation AUUCollectionFlowIndexPath

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.row = 0;
        self.section = 0;
        self.rowHeight = 0;
    }
    
    return self;
}

- (id)initWithHeight:(CGFloat)height
{
    self = [self init];
    
    if (self)
    {
        self.rowHeight = height;
    }
    
    return self;
}

@end
