//
//  SendMessageViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SendMessageViewController.h"

@interface SendMessageViewController ()<UITextFieldDelegate>
{
    UITextField *locationTextField;
}
@end

@implementation SendMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [CommonUtils colorWithHex:@"cccccc"];
    
    self.title = @"发送短信";
    [self createLeftBackNavBtn];
    
    
    [self initView];
}

#pragma mark - 初始化视图
- (void)initView{
    
    UIView *oneView = [[UIView alloc] initWithFrame:CGRectMake(15, NAV_TOP_HEIGHT+20, SCREEN_WIDTH - 30, 44)];
    oneView.layer.cornerRadius = 10.0;
    oneView.layer.borderWidth = 1;
    oneView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    oneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:oneView];
    
    
    UIImageView *locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 14, 18)];
    locationImageView.image   = [UIImage imageNamed:@"kuaidiyuan_icon_place"];
    [oneView addSubview:locationImageView];


    //输入代收地址的文本输入框
    locationTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(locationImageView.frame) + 10, 0, SCREEN_WIDTH - 30, 44)];
    locationTextField.returnKeyType = UIReturnKeyDone;
    locationTextField.borderStyle = UITextBorderStyleNone;
    locationTextField.delegate = self;
    locationTextField.placeholder = @"请输入代收地点地址";
    [oneView addSubview:locationTextField];
    
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,  CGRectGetMaxY(oneView.frame) + 10, CGRectGetWidth(oneView.frame), 20)];
    alertLabel.text = @"示例：学校东门传达室";
    alertLabel.font = [UIFont systemFontOfSize:14];
    alertLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:alertLabel];
    
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [submitBtn setFrame:CGRectMake(15, CGRectGetMaxY(oneView.frame) + 80,CGRectGetWidth(oneView.frame),44)];
    submitBtn.layer.cornerRadius = 10.0;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn addTarget:self action:@selector(makeSureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - 确认按钮响应方法
- (void)makeSureAction{
    
    if (self.courierSendSnsType == CourierSendSnsSingleType) {
        [self sendSingleSns];
    }else{
        [self sendMassSns];
    }
    
}
-(void)sendSingleSns
{
    if (locationTextField.text.length<=0) {
        [CommonUtils showToastWithStr:@"请输入短信内容"];
        return;
    }
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.courierSnsStr forKey:@"express_no"];
    [dic setValue:locationTextField.text forKey:@"sns"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]sendSingleSnsWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (model.responseCode ==ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"发送成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(void)sendMassSns
{
    if (locationTextField.text.length<=0) {
        [CommonUtils showToastWithStr:@"请输入短信内容"];
        return;
    }
    NSMutableArray * tempCourierIDArr = [NSMutableArray array];
    
    for (int i = 0; i<self.courierScanResultArr.count; i++) {
        CourierScanResultModel * model = [self.courierScanResultArr objectAtIndex:i];
        [tempCourierIDArr addObject:model.courierScanResultId];
    }
    NSString * courierSnsStr = [tempCourierIDArr componentsJoinedByString:@","];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:courierSnsStr forKey:@"express_nos"];
    [dic setValue:locationTextField.text forKey:@"sns"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]sendMassSnsWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (model.responseCode ==ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"发送成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
