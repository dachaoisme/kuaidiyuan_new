//
//  UserAccountManager.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "UserAccountManager.h"
#import "JPUSHService.h"
@implementation UserAccountManager

+ (instancetype)sharedInstance
{
    static UserAccountManager *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] init];
    });
    
    return sharedClient;
}

-(void)saveUserAccountWithUserInfoDic:(NSMutableDictionary *)userInfoDic
{
    
    NSString * userInfoKey = @"userInfo";
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:userInfoDic];
    for (NSString * key in [userInfoDic allKeys]) {
        NSString * value = [userInfoDic objectForKey:key];
        if ([value isEqual:[NSNull null]]) {
            [dic setValue:@"" forKey:key];
        }else{
            
        }
    }
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:userInfoKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self getUserInfo];
}
-(void)getUserInfo
{

    NSString * userInfoKey = @"userInfo";
    NSDictionary * userInfoDic = [[NSUserDefaults standardUserDefaults] objectForKey:userInfoKey];
    
    self.user_id   = [userInfoDic stringForKey:@"user_id"];
    self.usericon      = [userInfoDic stringForKey:@"icon"];
    self.userName       = [userInfoDic stringForKey:@"name"];
    self.userTelphone         = [userInfoDic stringForKey:@"telphone"];
    self.colledge_id         = [userInfoDic stringForKey:@"college_id"];
    
    if (self.user_id && self.user_id.length>0) {
        self.isLogin = YES;
    }else{
        self.isLogin = NO;
    }
    [self setJpushTags];
}

-(void)exitLogin
{
    NSString * userInfoKey = @"userInfo";
    [UserDefaultsDataDeal deleteKey:userInfoKey];
    [self getUserInfo];
    AppDelegate * appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate setRootViewController];
}
-(void)loginWithUserPhoneNum:(NSString *)phoneNum andPassWord:(NSString *)passWord
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneNum forKey:@"telphone"];
    [dic setObject:passWord forKey:@"passwd"];
    [[HttpClient sharedInstance]loginWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
        [[UserAccountManager sharedInstance]saveUserAccountWithUserInfoDic:model.responseCommonDic];
        AppDelegate * appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate setRootViewController];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
-(void)setJpushTags
{
    //设置tags和别名
    NSString * tag = [NSString stringWithFormat:@"user%@",self.user_id];
    NSSet  *set = [NSSet setWithObject:tag];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JPUSHService setTags:set alias:tag fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            NSLog(@"%d----%@---",iResCode,iAlias);
//            [CommonUtils showToastWithStr:[NSString stringWithFormat:@"注册别名成功:%@",iAlias]];
        }];
    });
    
}

@end
