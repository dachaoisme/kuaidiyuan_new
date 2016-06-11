//
//  IndexModel.h
//  kuaidiyuan
//
//  Created by lidachao on 16/6/11.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndexModel : NSObject
-(id)initWithDic:(NSDictionary *)dic;
@end

///快递信息model
@interface ExpressInfoModel : NSObject
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
@interface ExpressMessageModel : NSObject
/*
 "id": 1,
 "title": "dafds1111",
 "msg": "dsafadsfa",
 "create_at": "2016-06-10 09:46:38"
 
 */
@property(nonatomic,strong)NSString *expressMessageId;
@property(nonatomic,strong)NSString *expressMessageTitle;
@property(nonatomic,strong)NSString *expressMessageMsg;
@property(nonatomic,strong)NSString *expressMessageCreateTime;
-(id)initWithDic:(NSDictionary *)dic;
@end

///短信模板model 
@interface MessageTemplateModel : NSObject
/*
 "id": 2,
 "user_id": 1,
 "template": "dadag",
 "create_at": "2016-06-08 06:25:15"
 
 */
@property(nonatomic,strong)NSString *messageTemplateId;
@property(nonatomic,strong)NSString *messageTemplateUserId;
@property(nonatomic,strong)NSString *messageTemplateTemplate;
@property(nonatomic,strong)NSString *messageTemplateCreateTime;
-(id)initWithDic:(NSDictionary *)dic;
@end

