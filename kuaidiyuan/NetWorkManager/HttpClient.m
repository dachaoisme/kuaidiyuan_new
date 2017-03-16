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
/////////////////使用的学院派的接口/////////////////////

////////////快递员接口////////////////
///注册发送验证码
- (void)registerOfSendMessageWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_SEND_MESSAGE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

///校验手机号
- (void)checkSendMessageWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:CHECK_PHONE_CODE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
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
///修改手机号绑定
- (void)changeBindPhoneNumberWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:CHANGE_BIND_PHONE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}




///注册
- (void)registerAndSubmitWithParams:(NSDictionary *)params withSuccessBlock:(XYPNoneListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_REGISTER withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

///用户头像上传
- (void)uploadImageWithParams:(NSDictionary *)params withUploadDic:(NSDictionary *)uploadDic withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]postWithMethod:METHOD_OF_UPLOAD withParams:params withUploadDic:uploadDic withSuccess:^(HttpResponseCodeModel *model) {
        
        successBlock(model);
        
    } withFailBlock:^(NSError *error) {
        
        failBlock(error);
        
    }];
    
}


///上传身份证 等多张图片
- (void)uploadImagesWithParams:(NSDictionary *)params withUploadDic:(NSDictionary *)uploadDic withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]postWithMethod:METHOD_OF_IMAGES_UPLOAD withParams:params withUploadDic:uploadDic withSuccess:^(HttpResponseCodeModel *model) {
        
        successBlock(model);
        
    } withFailBlock:^(NSError *error) {
        
        failBlock(error);
        
    }];
    
}
///完善个人资料
- (void)perfectUserInfoWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_INFO_PERFECT withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
    
}

///搜索学校
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


///发快件取件消息接口
- (void)incompleteCourierWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_INCOMPLETE_COURIER_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

///送快递记录接口
- (void)expressHistoryWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_SEND_COURIER_HISTORY withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = nil;
        if (model.responseCode == ResponseCodeSuccess) {
            pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        }
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///设置快递员是上下班接口
- (void)configureWorkTimeWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_CONFIGURE_WORK withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

///设置快递已经送达接口
- (void)courierArrivedWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_COURIER_ARRIVE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}


///根据短信和订单号发送单个短信
- (void)sendSingleSnsWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_COURIER_SEND_SNS withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///保存扫描之后的快递信息
- (void)saveScanResultInfoWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_COURIER_SAVE_INFO_SNS withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
    
}
///扫码群发短信
- (void)sendMassSnsWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_COURIER_SEND_MASS_SNS withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

///冲发短信
- (void)resendSnsByExpressNoWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_COURIER_SEND_SNS_EXPRESSNO withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

///工作统计，收发多少个快件
- (void)statisticsCourierHistoryWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_COURIER_STATISTICS withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
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


#pragma mark - 集梦盒子一期 学院派二期
///登陆
- (void)loginWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:TWICE_METHOD_OF_LOGIN withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)getWorkStatusWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:TWICE_METHOD_OF_WORK_STATUS withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///选择快递公司
- (void)selectedCourierCompanyWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:TWICE_METHOD_OF_COURIER_COMPANY withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
@end
