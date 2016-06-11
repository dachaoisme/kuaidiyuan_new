//
//  IndexViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "IndexViewController.h"

#import "LoginViewController.h"
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


#pragma mark - 我的
-(void)leftItemActionWithBtn:(UIButton *)sender
{
    BOOL yesLogin = [UserAccountManager sharedInstance].isLogin;
    //需要先判断是否已经登陆
    if (yesLogin) {
        //收件箱界面
        //弹出我的界面
       
    }else{
        //进入登陆注册页面
        
        
    }
    
    
}
#pragma mark - 收件箱
-(void)rightItemActionWithBtn:(UIButton *)sender
{
    
    BOOL yesLogin = [UserAccountManager sharedInstance].isLogin;
    //需要先判断是否已经登陆
    if (yesLogin) {
        //收件箱界面
        [CommonUtils showToastWithStr:@"收件箱"];
    }else{
        //进入登陆注册页面
        
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
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
