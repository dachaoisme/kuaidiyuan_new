//
//  JMChangePasswordViewController.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/21.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMChangePasswordViewController.h"

@interface JMChangePasswordViewController ()<UITextFieldDelegate>
{
    
    UITextField *inputOldPasswordTextField;
    UITextField *inputPassNewTextField;
    
    UIButton    *sureBtn;
}

@end

@implementation JMChangePasswordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  =@"修改密码";
    [self createLeftBackNavBtn];
    self.view.backgroundColor = [CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    [self setContentView];
    
    
}
-(void)setContentView
{
    float space = 16;
    float width = SCREEN_WIDTH -2*space;
    float backgroundViewHeight = 48*2;
    float height = 48;
    
    UIView * backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, space+NAV_TOP_HEIGHT, SCREEN_WIDTH, backgroundViewHeight)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    //请输入密码
    inputOldPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(space, 0, width, height)];
    inputOldPasswordTextField.tag = 2;
    inputOldPasswordTextField.delegate = self;
    [inputOldPasswordTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    inputOldPasswordTextField.textAlignment = NSTextAlignmentLeft;
    inputOldPasswordTextField.borderStyle = UITextBorderStyleNone;
    inputOldPasswordTextField.placeholder = @"请输入旧密码";
    inputOldPasswordTextField.adjustsFontSizeToFitWidth = YES;
    inputOldPasswordTextField.returnKeyType = UIReturnKeyDone;
    inputOldPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backgroundView addSubview:inputOldPasswordTextField];
    
    //请输入密码
    inputPassNewTextField = [[UITextField alloc]initWithFrame:CGRectMake(space, CGRectGetMaxY(inputOldPasswordTextField.frame), width, height)];
    inputPassNewTextField.tag = 2;
    inputPassNewTextField.delegate = self;
    [inputPassNewTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    inputPassNewTextField.textAlignment = NSTextAlignmentLeft;
    inputPassNewTextField.borderStyle = UITextBorderStyleNone;
    inputPassNewTextField.placeholder = @"请设置新密码";
    inputPassNewTextField.adjustsFontSizeToFitWidth = YES;
    inputPassNewTextField.returnKeyType = UIReturnKeyDone;
    inputPassNewTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backgroundView addSubview:inputPassNewTextField];
    
    [UIFactory showLineInView:backgroundView color:@"e5e5e5" rect:CGRectMake(0, CGRectGetMaxY(inputOldPasswordTextField.frame)-0.5, SCREEN_WIDTH, 1)];
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 3.0;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[CommonUtils colorWithHex:NORMAL_HEIGHTLIGHT_COLOR]];
    [sureBtn setFrame:CGRectMake(space, CGRectGetMaxY(backgroundView.frame)+space, width, height)];
    [sureBtn setContentMode:UIViewContentModeCenter];
    [sureBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:sureBtn];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)sure:(UIButton *)sender
{
    if (inputOldPasswordTextField.text.length<=0 ) {
        [CommonUtils showToastWithStr:@"旧密码不能为空"];
        return;
    }
    if (inputPassNewTextField.text.length<=0 ) {
        [CommonUtils showToastWithStr:@"新密码不能为空"];
        return;
    }
    /*
     user_id int    必需    用户序号
     passwd   string    必需    新密码
     */
    //校验验证码
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserAccountManager sharedInstance].user_id forKey:@"user_id"];
    [dic setObject:inputOldPasswordTextField.text forKey:@"old_passwd"];
    [dic setObject:inputPassNewTextField.text forKey:@"new_passwd"];
    [[HttpClient sharedInstance]changePasswordWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            //NSDictionary * userInfoDic = [model.responseCommonDic objectForKey:@"data"];
            //若成功，应该是返回主页面，并且是已经登录状态
            [[UserAccountManager sharedInstance]loginWithUserPhoneNum:[UserAccountManager sharedInstance].userTelphone andPassWord:inputPassNewTextField.text];
        }else{
            //验证失败
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
