//
//  UserAccountManager.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAccountManager : NSObject
////////////////////校内、外快递员字段////////////////////
/*
"courier_id": 73,
"IDcard": "320342141123",//身份证号
"realname": "赵小四", //姓名
"college_name": "北京大学",//配送学校
"expresscompany": "圆通速递",//快递公司
"working": 0  //状态 1正在工作 0 不在工作
 */

/*
"courier_id": 1,
"user_id": 11,
"realname": "张三", //姓名
"IDcard": "320342141",//身份证号
 "college_name": "山东理工大学",//学校
 "working": 1 //状态 1正在工作 0 不在工作
"telphone": "15010141545",//
"college_id": 1,
"grade": "05级",//年级
"major": "园林设计",//专业
"StudentID": "03121243",//学号

*/

///快递员id
@property (nonatomic, strong) NSString *userCourierId;
///学院派
@property (nonatomic, strong) NSString *userXueYuanPaiId;
///快递员身份证号
@property (nonatomic, strong) NSString *userIDCard;
///用户真实姓名
@property (nonatomic, strong) NSString *userRealName;
///配送学校
@property (nonatomic, strong) NSString *userCollegeName;
///快递公司
@property (nonatomic, strong) NSString *userExpressCompany;
///工作状态
@property (nonatomic, strong) NSString *userWorkingStatus;
////////////////////校内快递员特有字段////////////////////
///快递公司
@property (nonatomic, strong) NSString *userTelphone;
///快递公司
@property (nonatomic, strong) NSString *userCollegeId;
///快递公司
@property (nonatomic, strong) NSString *userGrade;
///快递公司
@property (nonatomic, strong) NSString *userMajor;
///快递公司
@property (nonatomic, strong) NSString *userStudentID;

///通过工作统计接口，来统计收发多少件快递
@property (nonatomic, strong) NSString *userSendCourierNumber;
@property (nonatomic, strong) NSString *userReceiveCourierNumber;
////////////////////自定义那个////////////////////
///是否是登陆状态
@property (nonatomic, assign) BOOL isLogin;
///是校内快递员还是校外快递员
@property (nonatomic, assign) CourierRoleType userCourierRoleType;

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
