//
//  LoginViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/11.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "RegisterRoleView.h"
#import "ForgetPasswordViewController.h"

#import "RegisterViewController.h"

@interface LoginViewController ()<RegisterRoleViewDelegate>
{
    UITextField *phoneTextField;
    UITextField *passwordTextField;
    UIButton    *personalAccountBtn;
    UIButton    *teacherAccountBtn;
    UIButton    *loginBtn;
    UIButton    *registerBtn;
    UIButton    *justToLook;
    RegisterRoleView * registerRoleAlertView;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setContentView];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [self theTabBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
-(void)setContentView
{
    float topSpace = 96;
    float leftSpace = 39;
    float rightSpace = 35;
    float width = SCREEN_WIDTH - 35*2;
    float height = 48;
    float smallSpace = 15;
    float smallHeight = 36;
    
    
    //创建
    
    //logo
    UIImage * logoImage = [UIImage imageNamed:@"login_logo"];
    UIImageView * logoImageView = [UIFactory imageView:CGRectMake(leftSpace, topSpace, logoImage.size.width, logoImage.size.height) viewMode:UIViewContentModeScaleToFill image:@"login_logo"];
    [self.view addSubview:logoImageView];
    
    
    UILabel *showTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, NAV_TOP_HEIGHT + 20, SCREEN_WIDTH, 50)];
    showTextLabel.text = @"学院派快递员";
    showTextLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:showTextLabel];
    
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
    phoneTextField.placeholder = @"请输入手机号";
    phoneTextField.adjustsFontSizeToFitWidth = YES;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    phoneTextField.leftView = phoneImageView;
    [textFieldbackgroundView addSubview:phoneTextField];
    
    //密码输入框
    UIImageView * passwordImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_password"]];
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(boardHeight, CGRectGetMaxY(phoneTextField.frame), CGRectGetWidth(textFieldbackgroundView.frame)-2*boardHeight, height-boardHeight)];
    passwordTextField.tag = 2;
    passwordTextField.delegate = self;
    passwordTextField.textAlignment = NSTextAlignmentLeft;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.font = [UIFont systemFontOfSize:14];

    //myTextField.clearsOnBeginEditing = YES;//设置为YES当用点触文本字段时，字段内容会被清除
    passwordTextField.adjustsFontSizeToFitWidth = YES;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    passwordTextField.leftView = passwordImageView;
    passwordTextField.rightViewMode = UITextFieldViewModeAlways;
    [textFieldbackgroundView addSubview:passwordTextField];
    
    [UIFactory showLineInView:textFieldbackgroundView color:@"c2c3c4" rect:CGRectMake(0, CGRectGetMaxY(phoneTextField.frame), CGRectGetWidth(textFieldbackgroundView.frame), 0.5)];
    
    UIButton * forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPasswordBtn setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    [forgetPasswordBtn setFrame:CGRectMake(0, 0, 50, 30)];
    [forgetPasswordBtn addTarget:self action:@selector(forgetPasswordAccount:) forControlEvents:UIControlEventTouchUpInside];
    [forgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    passwordTextField.rightView = forgetPasswordBtn;
    
    
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
    
    //注册按钮
    registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    registerBtn.tag = 10002;
    registerBtn.layer.cornerRadius = 5.0;
    registerBtn.layer.masksToBounds = YES;
    [registerBtn setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    [registerBtn setFrame:CGRectMake(leftSpace, CGRectGetMaxY(loginBtn.frame)+smallSpace, width, height)];
    [registerBtn addTarget:self action:@selector(registerAccount:) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:@"申请成为快递员" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:registerBtn];
    
    justToLook = [UIButton buttonWithType:UIButtonTypeCustom];
    [justToLook setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [justToLook setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    [justToLook setFrame:CGRectMake(SCREEN_WIDTH-rightSpace-100, SCREEN_HEIGHT - 50, 100, height)];
    [justToLook addTarget:self action:@selector(justToLook:) forControlEvents:UIControlEventTouchUpInside];
    [justToLook setTitle:@"随便逛逛 >" forState:UIControlStateNormal];
    justToLook.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:justToLook];
    
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
#pragma mark - 选择个人账号登录或者企业账号登陆
-(void)selectedLoginMethodWithBtn:(UIButton *)sender
{
    if (sender.tag == 10001) {
        if (personalAccountBtn.selected) {
        }else{
            personalAccountBtn.selected = YES;
            teacherAccountBtn.selected = NO;
        }
    }else{
        if (teacherAccountBtn.selected) {
        }else{
            teacherAccountBtn.selected = YES;
            personalAccountBtn.selected = NO;
        }
    }
}

#pragma mark - 忘记密码
-(void)forgetPasswordAccount:(UIButton *)sender
{
    [CommonUtils showToastWithStr:@"忘记密码"];
    ForgetPasswordViewController * forgetPasswordVC = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
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
  role     string    必需    角色 1学生 2导师
  
  */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneTextField.text forKey:@"mobile"];
    [dic setObject:passwordTextField.text forKey:@"passwd"];
    [dic setObject:personalAccountBtn.selected?@"1":@"2" forKey:@"role"];
    [[HttpClient sharedInstance]loginWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"登陆成功"];
            //NSString * userid = [model.responseCommonDic objectForKey:@"user_id"];
            //NSString * points = [model.responseCommonDic objectForKey:@"points"];
            [[UserAccountManager sharedInstance]saveUserAccountWithUserInfoDic:model.responseCommonDic];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
    
}
#pragma mark - 注册
-(void)registerAccount:(UIButton *)sender
{
    
    //注册按钮的响应方法
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
#pragma mark - 随便看看
-(void)justToLook:(UIButton *)sender
{
    [CommonUtils showToastWithStr:@"随便看看"];
    [self.navigationController popViewControllerAnimated:YES];
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