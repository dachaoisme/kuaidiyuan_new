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

/*
 
 "id": 1,
 "telphone": "13718360864",//手机号码
 "company": "韵达快递",//快递公司
 "express_no": "323232",//快递单号
 "status": 0, //状态 1已送达 0 未送达
 "create_at": "2016-06-09 17:16:15"
 */

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.courierInfoId         = [dic stringForKey:@"id"];
        self.courierInfoTelephone  = [dic stringForKey:@"telphone"];
        self.courierInfoCompany    = [dic stringForKey:@"company"];
        self.courierInfoNum        = [dic stringForKey:@"express_no"];
        self.courierInfoStatus     = [dic stringForKey:@"status"];
        self.courierCreateTime     = [dic stringForKey:@"create_at"];
        
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
