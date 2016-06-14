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
///申请成为快递员
- (void)applyToCourierWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///登陆
- (void)loginWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
#pragma mark - 送快递相关
///送快递记录接口
- (void)expressHistoryWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///设置快递员是都上下班接口
- (void)configureWorkTimeWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///发快件取件消息接口
- (void)expressMessageWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///短信模板列表接口
- (void)messageTemplatesListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///添加短信模板接口
- (void)addMessageTemplatesWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///修改短信模板接口
- (void)updateMessageTemplatesWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///删除短信模板接口
- (void)deleteMessageTemplatesWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
@end


