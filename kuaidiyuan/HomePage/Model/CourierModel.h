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
 "express_type": 1,      //快递类型 具体数字含义 需求未定
 "express_no": "323232", //快递单号
 "status": 1,            //状态:0 未送达 1 已送达
 "create_at": "2016-06-09 17:16:15"
 
 */
@property(nonatomic,strong)NSString *expressId;
@property(nonatomic,strong)NSString *expressType;
@property(nonatomic,strong)NSString *expressNum;
@property(nonatomic,strong)NSString *expressStrtus;
@property(nonatomic,strong)NSString *expressCreateTime;
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
