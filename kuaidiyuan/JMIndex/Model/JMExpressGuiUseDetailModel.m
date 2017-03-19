//
//  JMExpressGuiUseDetailModel.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/19.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMExpressGuiUseDetailModel.h"

@implementation JMExpressGuiUseDetailModel


-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.ExpressGuiTotalCount       = [dic stringForKey:@"total_count"];
        self.ExpressGuiTypeName         = [dic stringForKey:@"door_type"];
        self.ExpressGuiFreeCount        = [dic stringForKey:@"free_count"];
    }
    
    return self;
}

@end

@implementation JMExpressGuiUseBigModel


-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.ExpressGuiTypeName       = @"";
        self.ExpressGuiTotalFreeCount         = @"";
        self.ExpressGuiTypeArray        = [NSMutableArray array];
    }
    
    return self;
}

@end
