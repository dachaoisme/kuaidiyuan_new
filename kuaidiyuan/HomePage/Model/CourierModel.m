//
//  CourierModel.m
//  kuaidiyuan
//
//  Created by lidachao on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "CourierModel.h"

@implementation CourierModel

@end
@implementation CourierInfoModel


-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.expressId         = [dic stringForKey:@"id"];
        self.expressType       = [dic stringForKey:@"express_type"];
        self.expressNum        = [dic stringForKey:@"express_no"];
        self.expressStrtus     = [dic stringForKey:@"status"];
        self.expressCreateTime = [dic stringForKey:@"create_at"];
        
    }
    
    return self;
    
}
@end

@implementation CourierIncompleteMessageModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.courierMessageId              = [dic stringForKey:@"id"];
        self.courierMessageExpressNum      = [dic stringForKey:@"express_no"];
        self.courierMessageStatus          = [dic stringForKey:@"status"];
        self.courierMessageCreateTime      = [dic stringForKey:@"create_at"];
        
    }
    return self;
    
}
@end
