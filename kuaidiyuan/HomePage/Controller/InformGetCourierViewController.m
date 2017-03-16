//
//  InformGetCourierViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "InformGetCourierViewController.h"

#import "SendMessageViewController.h"
#import "LDCPullDownMenuView.h"


@interface InformGetCourierViewController ()<UITextFieldDelegate,LDCPullDownMenuViewDelegate>
{
    UILabel *showAlertLabel;
    NSMutableArray * dataArr;
    NSMutableArray * companyArr;
    UITextField * telephoneTextField;
    NSString * companyName;
}
@end

@implementation InformGetCourierViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.camerView start];
    
    isOn = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"通知取快递";
    dataArr = [NSMutableArray array];
    companyArr = [NSMutableArray array];
    [self createLeftBackNavBtn];
    [self requestCompanyData];
    self.camerView.readerDelegate = self;
    self.camerView.tracksSymbols = YES;
    [self initControl];
    [self.camerView start];
}
-(void)doNavEventBack:(id)sender
{
    [self.camerView stop];
    [self.camerView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 初始化控件
 **/
- (void) initControl
{
    UIImageView* imageViewScan = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    //    imageViewScan.image = [UIImage imageNamed:@"kuaidiyuan_scan_view"];
    
    if (SCREEN_HEIGHT>480) {
        imageViewScan.image = [UIImage imageNamed:@"scan"];
    }else {
        imageViewScan.image = [UIImage imageNamed:@"scan480"];
    }
    
    imageViewScan.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageViewScan];
    

    self.line = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.line.image = [UIImage imageNamed:@"kuaidiyuan_scanner"];
    imageViewScan.userInteractionEnabled = YES;
    [imageViewScan addSubview:self.line];
    
    
    //已添加多少个快递
    showAlertLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT - 160, 150, 30)];
    showAlertLabel.font = [UIFont systemFontOfSize:14];
    showAlertLabel.text = @"已添加 0 快递";
    showAlertLabel.textColor = [UIColor whiteColor];
    [imageViewScan addSubview:showAlertLabel];
    
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"快递添加完成，去发送短信" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [submitBtn setFrame:CGRectMake(50, CGRectGetMaxY(showAlertLabel.frame)+10, SCREEN_WIDTH - 100,44)];
    submitBtn.layer.cornerRadius = 10.0;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn addTarget:self action:@selector(sendMessageAction) forControlEvents:UIControlEventTouchUpInside];
    [imageViewScan addSubview:submitBtn];

    
    //定时器，设定时间过1.5秒，
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}


-(void)animation1
{
    CGFloat orginX = (SCREEN_WIDTH - 180) / 2;
    CGFloat orginY = adjustsSizeToFitWithWidth320(130);
    CGFloat scope = adjustsSizeToFitWithWidth320((SCREEN_HEIGHT == 460?180:140) + 50);
    if ((NSInteger)scope%2) {
        scope += 1;
    }
    
    if (upOrdown == NO)
    {
        num ++;
        _line.frame = CGRectMake(orginX, orginY + 2*num , 180, 2);
        if (2*num == scope)
        {
            upOrdown = YES;
        }
    }
    else
    {
        num --;
        _line.frame = CGRectMake(orginX, orginY + 2*num, 180, 2);
        if (num == 0)
        {
            upOrdown = NO;
        }
    }
}

/**
 获取扫描完成后的结果
 **/
-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    symbol = nil;
    for(symbol in symbols)
    {
        
        codeMessage = symbol.data;
        [self scanSuccess];
        break;
    }
    if(!symbol)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"系统未发现二维码,请您继续扫描" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
#pragma mark - 处理扫描结果逻辑

#pragma mark - 处理扫描后的结果，弹出一框，展示出来
- (void)scanSuccess{
    [self.camerView stop];
    
    //扫描成功
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"快递信息" message:[NSString stringWithFormat:@"单号%@\n\n\n\n\n",codeMessage] preferredStyle:UIAlertControllerStyleAlert];
    
    NSArray *testArray;
    testArray = @[ companyArr];
    LDCPullDownMenuView *pullDownMenuView = [[LDCPullDownMenuView alloc] initWithArray:testArray selectedColor:[CommonUtils colorWithHex:@"00beaf"] withFrame:CGRectMake(10, 80, 240, 30)];
    pullDownMenuView.delegate = self;
    [alert.view addSubview:pullDownMenuView];
    
    //这里就可以设置子控件的frame,但是alert的frame不可以设置
    telephoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(pullDownMenuView.frame), CGRectGetMaxY(pullDownMenuView.frame) + 5, 240, 30)];//wight = 270;
    telephoneTextField.returnKeyType = UIReturnKeyDone;
    telephoneTextField.placeholder = @"请填写收件人手机号";
    telephoneTextField.borderStyle = UITextBorderStyleRoundedRect;//设置边框的样式
    telephoneTextField.delegate = self;
    //添加子控件也是直接add
    [alert.view addSubview:telephoneTextField];
    
    
    
    __weak typeof(self)weakSelf = self;
    
    //这跟 actionSheet有点类似了,因为都是UIAlertController里面的嘛
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"%@",telephoneTextField.text);//控制台中打印出输入的内容
        
        CourierScanResultModel * model = [[CourierScanResultModel alloc] initWithDic:nil];
        model.courierScanResultCompanyName = companyName;
        model.courierScanResultId =codeMessage;
        model.courierScanResultTelephone = telephoneTextField.text;
        
        [self saveScanResultWithModel:model];
        [self.camerView start];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.camerView start];
    }];
    //添加按钮
    [alert addAction:ok];
    [alert addAction:cancel];
    
    
    //以modal的方式来弹出
    [self presentViewController:alert animated:YES completion:^{ }];
    
}
- (void)PullDownMenu:(LDCPullDownMenuView *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    companyName = [companyArr objectAtIndex:row];
}
//
/////确认送达
//-(void)sureCourierArrive
//{
//    [self.camerView stop];
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    [dic setObject:codeMessage forKey:@"express_no"];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [[HttpClient sharedInstance]sendMassSnsWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
//        [self.camerView start];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        if (model.responseCode ==ResponseCodeSuccess) {
//            [CommonUtils showToastWithStr:@""];
//        }else{
//            [CommonUtils showToastWithStr:model.responseMsg];
//        }
//    } withFaileBlock:^(NSError *error) {
//        [self.camerView start];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }];
//    
//}
#pragma mark - 选择快递公司
-(void)requestCompanyData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"size"];
    [dic setObject:@"100" forKey:@"page"];
    [[HttpClient sharedInstance]selectedCourierCompanyWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSArray * dicArr = (NSArray *)model.responseCommonDic;
        [companyArr addObjectsFromArray:dicArr];
        companyName = [companyArr firstObject];
    } withFaileBlock:^(NSError *error) {
        
    }];
    
    
}
-(void)saveScanResultWithModel:(CourierScanResultModel *)scanResultmodel
{
    /*
     courier_id      int     必需      快递员序号
     express_no      string  必需     快递单号  //客户端要保存一份快递单号，用户发送短信
     telphone        string  必需     手机号码
     company         string  非必需   快递公司名称
     */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserAccountManager sharedInstance].user_id forKey:@"courier_id"];
    [dic setObject:scanResultmodel.courierScanResultId forKey:@"express_no"];
    [dic setObject:scanResultmodel.courierScanResultTelephone forKey:@"telphone"];
    [dic setObject:scanResultmodel.courierScanResultCompanyName forKey:@"company"];
    
    [[HttpClient sharedInstance]saveScanResultInfoWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            ///请求成功
            [dataArr addObject:scanResultmodel];
            showAlertLabel.text = [NSString stringWithFormat:@"已添加 %d 快递",[dataArr count]];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
        
    } withFaileBlock:^(NSError *error) {
        
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 跳转到发送短息页面
- (void)sendMessageAction{
    if (dataArr.count<=0) {
        [CommonUtils showToastWithStr:@"请先扫描添加快件哦"];
        return;
    }
    //发送短信页面
    SendMessageViewController *sendMessageVC = [[SendMessageViewController alloc] init];
    sendMessageVC.courierScanResultArr = dataArr;
    sendMessageVC.courierSendSnsType = CourierSendSnsMassType;
    [self.navigationController pushViewController:sendMessageVC animated:YES];
    
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
