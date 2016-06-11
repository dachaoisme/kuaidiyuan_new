//
//  HttpClient.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpServer.h"



@interface HttpClient : NSObject

/**
 *  @brief  单利初始化
 *
 *  @param
 *  @return
 */
+ (instancetype)sharedInstance;

#pragma mark - 用户相关
/**
 *  @brief  登陆
 *
 *  @param
 *
 *  @return
 */

- (void)loginWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  发送验证码
 *
 *  @param
 *
 *  @return
 */

- (void)registerOfSendMessageWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  提交并注册
 *
 *  @param
 *
 *  @return
 */

- (void)registerAndSubmitWithParams:(NSDictionary *)params withSuccessBlock:(XYPNoneListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  忘记密码-----校验验证码，验证手机号和验证码是否匹配
 *
 *  @param
 *
 *  @return
 */

- (void)validateTelephoneAndSecurityCodeWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  修改密码
 *
 *  @param
 *
 *  @return
 */

- (void)changePasswordWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  根据关键字查询学校
 *
 *  @param
 *
 *  @return
 */

- (void)searchCollegeWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  更新个人用户资料
 *
 *  @param
 *
 *  @return
 */

- (void)updateStudentInfoWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

/**
 *  @brief  更新导师用户资料
 *
 *  @param
 *
 *  @return
 */

- (void)updateTeacherInfoWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

/**
 *  @brief  上传用户头像
 *
 *  @param
 *
 *  @return
 */

- (void)uploadImageWithParams:(NSDictionary *)params withUploadDic:(NSDictionary *)uploadDic withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

#pragma mark - 我的

///个人中心-我的积分
- (void)mineToGetPointsListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///个人中心-我的钱包
- (void)mineToGetWalletsListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///个人中心-意见反馈
- (void)feedBackWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

///个人中心-关于我们
- (void)aboutUsWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

#pragma mark - 收藏相关
///添加收藏
- (void)addCollectionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///取消收藏
- (void)cancelCollectionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///验证是否已经被收藏
- (void)checkCollectionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

@end


