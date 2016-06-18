//
//  UserAccountManager.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAccountManager : NSObject

///快递员id
@property (nonatomic, strong) NSString *userCourierId;
///学院派
@property (nonatomic, strong) NSString *userXueYuanPaiId;
///用户头像
@property (nonatomic, strong) NSString *userIcon;
///用户真实姓名
@property (nonatomic, strong) NSString *userRealName;
///用户手机号
@property (nonatomic, strong) NSString *userTelephoneNum;
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
