//
//  CourierBtnView.m
//  kuaidiyuan
//
//  Created by 王园园 on 2017/5/7.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "CourierBtnView.h"

@implementation CourierBtnView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setContentView];
    }
    return self;
}
-(void)setContentView
{
    
    UIButton * columnImageViewBtn = [[UIButton alloc] initWithFrame:CGRectMake((100 - 32)/2, 0, 32, 47) ];
    [self addSubview:columnImageViewBtn];
    self.columnImageViewBtn = columnImageViewBtn;
    
    
    UILabel * columnTitileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(columnImageViewBtn.frame) + 10, 100, 16)];
    columnTitileLable.textAlignment = NSTextAlignmentCenter;
    columnTitileLable.textColor = [UIColor whiteColor];
    columnTitileLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:columnTitileLable];
    self.columnTitileLable = columnTitileLable;
    
}

@end
