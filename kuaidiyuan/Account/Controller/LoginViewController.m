//
//  LoginViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/11.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"


#import "ApplyCourierViewController.h"

#import "CourierHomePageViewController.h"

@interface LoginViewController ()
{
    UITextField *phoneTextField;
    UITextField *passwordTextField;
    UIButton    *teacherAccountBtn;
    UIButton    *loginBtn;
    UIButton    *registerBtn;
    UIButton    *justToLook;
}
@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setContentView];
}

-(void)setContentView
{
    float topSpace = 96;
    float leftSpace = 39;
    float width = SCREEN_WIDTH - 35*2;
    float height = 48;
    float smallSpace = 15;
    
    
    //创建大背景视图
    //大的背景图
    UIImageView * backgroundImageView = [UIFactory imageView:self.view.frame viewMode:UIViewContentModeScaleToFill image:@"kuaidiyuan_login_bg@2x.jpg"];
    [self.view addSubview:backgroundImageView];
    
    //logo
    UIImage * logoImage = [UIImage imageNamed:@"login_logo"];
    UIImageView * logoImageView = [UIFactory imageView:CGRectMake(leftSpace, topSpace, logoImage.size.width, logoImage.size.height) viewMode:UIViewContentModeScaleToFill image:@"login_logo"];
    [self.view addSubview:logoImageView];
    
    float boardHeight = 0.5;
    
    UIView *textFieldbackgroundView = [[UIView alloc]initWithFrame:CGRectMake(leftSpace, CGRectGetMaxY(logoImageView.frame)+60 , width, height *2)];
    textFieldbackgroundView.layer.borderColor = [CommonUtils colorWithHex:@"c2c3c4"].CGColor;
    textFieldbackgroundView.layer.borderWidth = boardHeight;
    [self.view addSubview:textFieldbackgroundView];
    
    //手机号输入框
    UIImageView * phoneImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_phone"]];
    phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(boardHeight, boardHeight, CGRectGetWidth(textFieldbackgroundView.frame)-2*boardHeight, height-boardHeight)];
    phoneTextField.tag = 1;
    phoneTextField.delegate = self;
    phoneTextField.textAlignment = NSTextAlignmentLeft;
    phoneTextField.borderStyle = UITextBorderStyleNone;
    phoneTextField.font = [UIFont systemFontOfSize:14];
    phoneTextField.placeholder = @"快递员编号或手机号";
    phoneTextField.adjustsFontSizeToFitWidth = YES;
    phoneTextField.text = @"13351540959";
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    phoneTextField.returnKeyType = UIReturnKeyDone;
    phoneTextField.leftView = phoneImageView;
    [textFieldbackgroundView addSubview:phoneTextField];
    
    //密码输入框
    UIImageView * passwordImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_password"]];
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(boardHeight, CGRectGetMaxY(phoneTextField.frame), CGRectGetWidth(textFieldbackgroundView.frame)-2*boardHeight, height-boardHeight)];
    passwordTextField.tag = 2;
    passwordTextField.delegate = self;
    passwordTextField.textAlignment = NSTextAlignmentLeft;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.placeholder = @"密码";
    passwordTextField.text = @"1";
    passwordTextField.font = [UIFont systemFontOfSize:14];

    //myTextField.clearsOnBeginEditing = YES;//设置为YES当用点触文本字段时，字段内容会被清除
    passwordTextField.adjustsFontSizeToFitWidth = YES;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    passwordTextField.leftView = passwordImageView;
    passwordTextField.rightViewMode = UITextFieldViewModeAlways;
    [textFieldbackgroundView addSubview:passwordTextField];
    
    //登陆按钮
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    loginBtn.tag = 10002;
    loginBtn.layer.cornerRadius = 5.0;
    [loginBtn setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    [loginBtn setFrame:CGRectMake(leftSpace, CGRectGetMaxY(textFieldbackgroundView.frame)+smallSpace, width, height)];
    [loginBtn addTarget:self action:@selector(loginAccount:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:loginBtn];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignTheTextField];
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self resignTheTextField];
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self resignTheTextField];
}

-(void)resignTheTextField
{
    if (phoneTextField.isFirstResponder) {
        [phoneTextField resignFirstResponder];
    }
    if (passwordTextField.isFirstResponder) {
        [passwordTextField resignFirstResponder];
    }
}

#pragma mark - 登陆
-(void)loginAccount:(UIButton *)sender
{
    
    NSString * phoneNum = phoneTextField.text;
    if (!(phoneNum.length==11 && [CommonUtils checkPhoneNumIsAvailableWithPhoneNumString:phoneNum])) {
        [CommonUtils showToastWithStr:@"请输入有效手机号"];
        return;
    }
    if (passwordTextField.text.length<=0 ) {
        [CommonUtils showToastWithStr:@"密码不能为空"];
        return;
    }
    /*
  mobile  string    必需    手机号码
  passwd   string    必需    密码
  */

    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneTextField.text forKey:@"telphone"];
    [dic setObject:passwordTextField.text forKey:@"passwd"];
    [[HttpClient sharedInstance]loginWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"登陆成功"];
            [[UserAccountManager sharedInstance]saveUserAccountWithUserInfoDic:model.responseCommonDic];
            AppDelegate * appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
            [appDelegate setRootViewController];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
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
