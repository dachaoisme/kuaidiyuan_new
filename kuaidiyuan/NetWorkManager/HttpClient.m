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
- (void)loginWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_LOGIN withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)registerOfSendMessageWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_SEND_MESSAGE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)registerAndSubmitWithParams:(NSDictionary *)params withSuccessBlock:(XYPNoneListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_REGISTER withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)validateTelephoneAndSecurityCodeWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_CHECKING_MESSAGE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)changePasswordWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_UPDATE_PASSWORD withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)searchCollegeWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_COLLEGE_SEARCH withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)updateStudentInfoWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_UPDATE_STUDENT_INFO withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)updateTeacherInfoWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_UPDATE_TEACHER_INFO withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)uploadImageWithParams:(NSDictionary *)params withUploadDic:(NSDictionary *)uploadDic withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]postWithMethod:METHOD_OF_UPLOAD withParams:params withUploadDic:uploadDic withSuccess:^(HttpResponseCodeModel *model) {
        
        successBlock(model);
        
    } withFailBlock:^(NSError *error) {
        
        failBlock(error);
        
    }];
    
}



#pragma mark - 我的
///个人中心-我的积分
- (void)mineToGetPointsListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_MINE_POINTS_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///个人中心-我的钱包
- (void)mineToGetWalletsListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_MINE_WALLET_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///个人中心-意见反馈
- (void)feedBackWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_MINE_FEED_BACK withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

///个人中心-关于我们
- (void)aboutUsWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock{
    
    [[HttpServer sharedInstance]getWithMethod:METHOD_MINE_ABOUT_US withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
#pragma mark - 收藏相关
///添加收藏
- (void)addCollectionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_COLLECTION_ADD withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///取消收藏
- (void)cancelCollectionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_COLLECTION_CANCEL withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///验证是否已经被收藏
- (void)checkCollectionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_COLLECTION_CHECK withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}


@end
