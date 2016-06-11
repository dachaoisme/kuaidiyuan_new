//
//  IndexViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "IndexViewController.h"
#import "LoginViewController.h"
#import "AccountUserModel.h"
#import "IndexModel.h"
@interface IndexViewController ()
{
    
}
@end

@implementation IndexViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self theTabBarHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"首页"];
    [self creatLeftNavWithImageName:@"nav_icon_profile"];
    [self creatRightNavWithImageName:@"nav_icon_msg"];
   
}
#pragma mark -接口相关
#pragma mark - 申请为快递员
-(void)applyToCourier
{
    /*
     
     realname  string  必需    真实姓名
     IDcard    string  必需    身份证号码
     college   string  必需    学校
     grade     string  必需    年级
     major     string  必需    专业
     studentID string  必需    学号
     */
    ApplyCourierModel * courierModel = [[ApplyCourierModel alloc]initWithDic:nil];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:courierModel.courierRealName forKey:@"realname"];
    [dic setValue:courierModel.courierIdentityCard forKey:@"IDcard"];
    [dic setValue:courierModel.courierCollege forKey:@"college"];
    [dic setValue:courierModel.courierClass forKey:@"grade"];
    [dic setValue:courierModel.courierMajor forKey:@"major"];
    [dic setValue:courierModel.courierStudentID forKey:@"studentID"];
    [[HttpClient sharedInstance]applyToCourierWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            ///申请成功
        }else{
            ///申请失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [CommonUtils showToastWithStr:@"请检查您的网络"];
    }];
}

#pragma mark - 登陆
-(void)login
{
    /*
     telphnoe   string  必需    手机号码
     passwd     string  必需    密码
     */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:@"手机号" forKey:@"telphnoe"];
    [dic setValue:@"密码" forKey:@"passwd"];
    
    [[HttpClient sharedInstance]loginWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            ///登陆成功
        }else{
            ///登陆失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [CommonUtils showToastWithStr:@"请检查您的网络"];
    }];
}
#pragma mark - 送快递记录
-(void)expressHistory
{
    NSMutableArray *expressHistoryArr = [NSMutableArray array];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [[HttpClient sharedInstance]expressHistoryWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        if (responseModel.responseCode==ResponseCodeSuccess) {
            NSArray * dicArr = [ListDic objectForKey:@"lists"];
            for (NSDictionary * dic in dicArr) {
                ExpressInfoModel *expressInfoModel = [[ExpressInfoModel alloc] initWithDic:dic];
                [expressHistoryArr addObject:expressInfoModel];
            }
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}

#pragma mark - 设置快递员上下班
-(void)configureCouriserWorkTime
{
    /*
     courier_id      int         必需      快递员序号
     working         int         必需      设置上下班 1上班 0下班
     */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"courier_id"];
    [dic setValue:@"1" forKey:@"working"];
    
    [[HttpClient sharedInstance]configureWorkTimeWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            ///设置成功
            [CommonUtils showToastWithStr:@"设置成功"];
        }else{
            ///设置失败失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [CommonUtils showToastWithStr:@"请检查您的网络"];
    }];
}

#pragma mark - 发快件取件消息接口
-(void)expressMessageList
{
    NSMutableArray *expressHistoryArr = [NSMutableArray array];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [[HttpClient sharedInstance]expressMessageWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        if (responseModel.responseCode==ResponseCodeSuccess) {
            NSArray * dicArr = [ListDic objectForKey:@"lists"];
            for (NSDictionary * dic in dicArr) {
                ExpressMessageModel *expressInfoModel = [[ExpressMessageModel alloc] initWithDic:dic];
                [expressHistoryArr addObject:expressInfoModel];
            }
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}


#pragma mark - 短信模板列表
-(void)messageTemplatesList
{
    NSMutableArray *messageTemplateModelArr = [NSMutableArray array];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [[HttpClient sharedInstance]messageTemplatesListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        if (responseModel.responseCode==ResponseCodeSuccess) {
            NSArray * dicArr = [ListDic objectForKey:@"lists"];
            for (NSDictionary * dic in dicArr) {
                MessageTemplateModel *expressInfoModel = [[MessageTemplateModel alloc] initWithDic:dic];
                [messageTemplateModelArr addObject:expressInfoModel];
            }
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}

#pragma mark - 添加短信模板
-(void)addMessageTemplate
{
    /*
     user_id     int      必需    用户序号
     template    string   必需    模板内容
     */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:@"欢迎光临，欢迎光临欢迎光临欢迎光临" forKey:@"template"];
    
    [[HttpClient sharedInstance]addMessageTemplatesWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            ///设置成功
            [CommonUtils showToastWithStr:@"添加模板成功"];
        }else{
            ///设置失败失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [CommonUtils showToastWithStr:@"请检查您的网络"];
    }];
}

#pragma mark - 修改短信模板
-(void)updateMessageTemplate
{
    /*
     id          int      必需    模板序号
     template    string   必需    模板内容
     */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:@"模板序号" forKey:@"id"];
    [dic setValue:@"欢迎光临，欢迎光临欢迎光临欢迎光临" forKey:@"template"];
    
    [[HttpClient sharedInstance]updateMessageTemplatesWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            ///设置成功
            [CommonUtils showToastWithStr:@"更新成功"];
        }else{
            ///设置失败失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [CommonUtils showToastWithStr:@"请检查您的网络"];
    }];
}

#pragma mark - 删除短信模板
-(void)deleteMessageTemplate
{
    /*
     id          int      必需    模板序号
     */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:@"模板序号" forKey:@"id"];
    
    [[HttpClient sharedInstance]deleteMessageTemplatesWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            ///设置成功
            [CommonUtils showToastWithStr:@"删除成功"];
        }else{
            ///设置失败失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [CommonUtils showToastWithStr:@"请检查您的网络"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
