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
    /*
     "courier_id": 1,
     "user_id": 11,
     "realname": "张三", //姓名
     "IDcard": "320342141",//身份证号
     "college_name": "山东理工大学",//学校
     "working": 1 //状态 1正在工作 0 不在工作
     "expresscompany": "圆通速递",//快递公司
     
     "telphone": "15010141545",//
     "college_id": 1,
     "grade": "05级",//年级
     "major": "园林设计",//专业
     "StudentID": "03121243",//学号
     
     */
    NSString * userInfoKey = @"userInfo";
    NSDictionary * userInfoDic = [[NSUserDefaults standardUserDefaults] objectForKey:userInfoKey];
    
    self.userXueYuanPaiId   = [userInfoDic stringForKey:@"user_id"];
    self.userCourierId      = [userInfoDic stringForKey:@"courier_id"];
    self.userRealName       = [userInfoDic stringForKey:@"realname"];
    self.userIDCard         = [userInfoDic stringForKey:@"IDcard"];
    self.userCollegeName    = [userInfoDic stringForKey:@"college_name"];
    self.userExpressCompany = [userInfoDic stringForKey:@"expresscompany"];//校外快递员有，校内快递员没有
    self.userWorkingStatus  = [userInfoDic stringForKey:@"working"];
    self.userTelphone       = [userInfoDic stringForKey:@"telphone"];
    self.userCollegeId      = [userInfoDic stringForKey:@"college_id"];
    self.userGrade          = [userInfoDic stringForKey:@"grade"];
    self.userMajor          = [userInfoDic stringForKey:@"major"];
    self.userStudentID      = [userInfoDic stringForKey:@"StudentID"];
    

    if (self.userCourierId && self.userCourierId.length>0) {
        self.isLogin = YES;
    }else{
        self.isLogin = NO;
    }

    if (self.userXueYuanPaiId && self.userXueYuanPaiId.length>0) {
        self.userCourierRoleType = CourierRoleTypeOfSchool;
    }else{
        self.userCourierRoleType = CourierRoleTypeUnScholl;
    }
    [self setJpushTags];
}

-(void)exitLogin
{
    NSString * userInfoKey = @"userInfo";
    [UserDefaultsDataDeal deleteKey:userInfoKey];
    [self getUserInfo];
}
-(void)loginWithUserPhoneNum:(NSString *)phoneNum andPassWord:(NSString *)passWord
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneNum forKey:@"telphone"];
    [dic setObject:passWord forKey:@"passwd"];
    [[HttpClient sharedInstance]loginWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
        [[UserAccountManager sharedInstance]saveUserAccountWithUserInfoDic:model.responseCommonDic];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
-(void)setJpushTags
{
    //设置tags和别名
    NSString * tag = [NSString stringWithFormat:@"user%@",self.userCourierId];
    NSSet  *set = [NSSet setWithObject:tag];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JPUSHService setTags:set alias:tag fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            NSLog(@"%d----%@---",iResCode,iAlias);
//            [CommonUtils showToastWithStr:[NSString stringWithFormat:@"注册别名成功:%@",iAlias]];
        }];
    });
    
}
@end
