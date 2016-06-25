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
    /*
     "id": 1,
     "icon": "http://api.c.com/backend/web/uploads/20160612/14657697061004.jpg",//头像
     "nickname": "王大山",//姓名
     "sex": 1,//性别 1男 0女
     "address": "大法",//收货地址
     "fetchtime": "打法是否大师傅",//取件时间
     "telphone": "137183760983",//联系电话
     "status": 1,//取件状态 -1取消取件 0 等待取件 1已取件
     "create_at": "2016-06-04 23:21:30"
     
     */

    self = [super init];
    if (self) {
        self.courierMessageId                  = [dic stringForKey:@"id"];
        self.courierMessageIcon                = [dic stringForKey:@"icon"];
        self.courierMessageNickName            = [dic stringForKey:@"nickname"];
        self.courierMessageSex                 = [[dic stringForKey:@"sex"] integerValue];
        self.courierMessageAdress              = [dic stringForKey:@"address"];
        self.courierMessageIdFetchTime         = [dic stringForKey:@"fetchtime"];
        self.courierMessageIdFetchTelephone    = [dic stringForKey:@"telphone"];
        self.courierMessageStatus              = [[dic stringForKey:@"status"] integerValue];
        self.courierMessageCreateTime          = [dic stringForKey:@"create_at"];
        
    }
    return self;
    
}
@end
