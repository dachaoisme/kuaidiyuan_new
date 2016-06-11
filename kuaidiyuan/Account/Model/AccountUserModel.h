//
//  AccountUserModel.h
//  kuaidiyuan
//
//  Created by lidachao on 16/6/11.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountUserModel : NSObject

@end



@interface ApplyCourierModel : NSObject

/*
 user_id   int     非必需    用户序号
 realname  string  必需    真实姓名
 IDcard    string  必需    身份证号码
 college   string  必需    学校
 grade     string  必需    年级
 major     string  必需    专业
 studentID string  必需    学号
 */
@property(nonatomic,strong)NSString * courierRealName;
@property(nonatomic,strong)NSString * courierIdentityCard;
@property(nonatomic,strong)NSString * courierCollege;
@property(nonatomic,strong)NSString * courierClass;
@property(nonatomic,strong)NSString * courierMajor;
@property(nonatomic,strong)NSString * courierStudentID;

-(id)initWithDic:(NSDictionary *)dic;

@end