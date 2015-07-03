//
//  CustomCollectionViewCell.m
//  WaterTesting
//
//  Created by 胡金友 on 15/7/3.
//  Copyright (c) 2015年 胡金友. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.label.numberOfLines = 0 ;
        self.label.lineBreakMode = NSLineBreakByCharWrapping;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.label];
    }
    
    return self;
}

@end
