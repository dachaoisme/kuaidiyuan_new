//
//  CourierModel.h
//  kuaidiyuan
//
//  Created by lidachao on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourierModel : NSObject

@end



///快递信息model
@interface CourierInfoModel : NSObject
/*
 
 "id": 1,
 "telphone": "13718360864",//手机号码
 "company": "韵达快递",//快递公司
 "express_no": "323232",//快递单号
 "status": 0, //状态 1已送达 0 未送达
 "create_at": "2016-06-09 17:16:15"
 */
@property(nonatomic,strong)NSString *courierInfoId;
@property(nonatomic,strong)NSString *courierInfoTelephone;
@property(nonatomic,strong)NSString *courierInfoCompany;
@property(nonatomic,strong)NSString *courierInfoNum;
@property(nonatomic,strong)NSString *courierInfoStatus;
@property(nonatomic,strong)NSString *courierCreateTime;
-(id)initWithDic:(NSDictionary *)dic;
@end

///取件消息model
@interface CourierIncompleteMessageModel : NSObject
/*
 "id": 2,
 "express_no": "13718360863",
 "status":0,
 "create_at": "2016-06-13 22:48:15"
 
 */
@property(nonatomic,strong)NSString *courierMessageId;
@property(nonatomic,strong)NSString *courierMessageExpressNum;
@property(nonatomic,strong)NSString *courierMessageStatus;
@property(nonatomic,strong)NSString *courierMessageCreateTime;
-(id)initWithDic:(NSDictionary *)dic;
@end
