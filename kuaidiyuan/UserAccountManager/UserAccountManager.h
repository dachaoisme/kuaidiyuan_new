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
 "user_id": 4,//用户序号
 "points": 0, //积分
 "role": 1,  //1学生 2导师
 "icon": "", //头像
 "nickname": "答案的", //昵称
 "mobile": "13718360863",//手机号码
 "college_id": 1, //学校序号
 "college_name": "北京大学",
 "sex": 1,       //性别 1男 0女
 "realname": "", //真实姓名
 "idcard": 0,   //身份证号
 "company": "", //工作单位
 "job": "",    //职务
 "telphone": "", //联系电话
 "email": "",
 "skillful": "",//擅长辅导领域
 "tutorbackground": "" //导师背景
 */

///快递员id
@property (nonatomic, strong) NSString *userCourierId;
///学院派
@property (nonatomic, strong) NSString *userXueYuanPaiId;
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
