//
//  HttpClient.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "HttpClient.h"

@implementation HttpClient


+ (instancetype)sharedInstance {
    
    static HttpClient *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark - 用户相关
///申请成为快递员
- (void)applyToCourierWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_APPLY_COURIER withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

///登陆
- (void)loginWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_APPLY_LOGIN withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///送快递记录接口
- (void)expressHistoryWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_SEND_EXPRESS_HISTORY withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///设置快递员是都上下班接口
- (void)configureWorkTimeWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_CONFIGURE_WORK withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///发快件取件消息接口
- (void)expressMessageWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_CONFIGURE_SEND_MESSAGE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

///短信模板列表接口
- (void)messageTemplatesListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_CONFIGURE_TEMPLATES_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///添加短信模板接口
- (void)addMessageTemplatesWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_CONFIGURE_TEMPLATES_CREATE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///修改短信模板接口
- (void)updateMessageTemplatesWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_CONFIGURE_TEMPLATES_UPDATE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

///删除短信模板接口
- (void)deleteMessageTemplatesWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_CONFIGURE_TEMPLATES_DELETE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
@end
