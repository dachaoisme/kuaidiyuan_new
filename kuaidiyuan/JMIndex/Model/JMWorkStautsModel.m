//
//  JMWorkStautsModel.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMWorkStautsModel.h"

@implementation JMWorkStautsModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.workStautsOfRukuCnt      = [dic stringForKey:@"ruku_cnt"];
        self.workStautsOfRuguiCnt     = [dic stringForKey:@"rugui_cnt"];
        self.workStautsOfRuguojiaCnt  = [dic stringForKey:@"ruguojia_cnt"];
        self.workStautsOfTime_len     = [dic stringForKey:@"time_len"];
    }
    
    return self;
}

@end
