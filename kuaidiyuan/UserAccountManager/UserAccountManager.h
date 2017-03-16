//
//  UserAccountManager.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAccountManager : NSObject
/*
icon = admin;
name = "\U5f20\U4e09";
telphone = 13351540959;
"user_id" = 1;
*/

///用户角色
@property (nonatomic, strong) NSString *usericon;
///用户姓名
@property (nonatomic, strong) NSString *userName;
///用户手机号
@property (nonatomic, strong) NSString *userTelphone;
///用户id
@property (nonatomic, strong) NSString *user_id;



///通过工作统计接口，来统计收发多少件快递
@property (nonatomic, strong) NSString *userSendCourierNumber;
@property (nonatomic, strong) NSString *userReceiveCourierNumber;
////////////////////自定义那个////////////////////
///是否是登陆状态
@property (nonatomic, assign) BOOL isLogin;


+ (instancetype)sharedInstance;

/**
 *  @brief  保存登陆信息
 *
 *  @param
 *
 *  @return
 */
-(void)saveUserAccountWithUserInfoDic:(NSDictionary *)userInfoDic;
/**
 *  @brief  获取用户信息，并更新属性的值
 *
 *  @param
 *
 *  @return
 */
-(void)getUserInfo;
/**
 *  @brief  获取用户id
 *
 *  @param
 *
 *  @return
 */

/**
 *  @brief  退出登录
 *
 *  @param
 *
 *  @return
 */
-(void)exitLogin;

-(void)loginWithUserPhoneNum:(NSString *)phoneNum andPassWord:(NSString *)passWord;

@end
