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
@property(nonatomic,strong)NSString *courierMessageId;
@property(nonatomic,strong)NSString *courierMessageIcon;
@property(nonatomic,strong)NSString *courierMessageNickName;
@property(nonatomic,assign)UserInfoSex courierMessageSex;
@property(nonatomic,strong)NSString *courierMessageAdress;
@property(nonatomic,strong)NSString *courierMessageIdFetchTime;
@property(nonatomic,strong)NSString *courierMessageIdFetchTelephone;
@property(nonatomic,assign)courierMessageStatus courierMessageStatus;
@property(nonatomic,strong)NSString *courierMessageCreateTime;
-(id)initWithDic:(NSDictionary *)dic;
@end
