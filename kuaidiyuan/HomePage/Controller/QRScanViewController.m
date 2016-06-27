//
//  QRScanViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "QRScanViewController.h"



@interface QRScanViewController ()

@property (nonatomic,strong)UIImageView* imageViewScan;

@end

@implementation QRScanViewController

FOUNDATION_EXPORT CGFloat adjustsSizeToFitWithWidth320(CGFloat size) {
    
    CGFloat width = SCREEN_WIDTH;
    return round(size * width/320);
}

- (void) viewDidAppear: (BOOL) animated
{
    // run the reader when the view is visible
    [self.camerView start];
    [super viewDidAppear:YES];
}

- (void) viewWillDisappear: (BOOL) animated
{
    [self.camerView stop];
    
    
    [super viewWillDisappear:YES];
}


- (void)viewDidDisappear:(BOOL)animated
{
    
    [self.camerView removeFromSuperview];
    [self.view removeFromSuperview];


    [super viewDidDisappear:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    isOn = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"扫一扫确认送达";
    [self createLeftBackNavBtn];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:41.0/255.0 alpha:1.0];

    
    self.camerView.readerDelegate = self;
    self.camerView.tracksSymbols = YES;
    
    
    [self initControl];
    
    
//    [self.camerView start];
}


/**
 初始化控件
 **/
- (void) initControl
{
    UIImageView* imageViewScan = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (SCREEN_HEIGHT>480) {
        imageViewScan.image = [UIImage imageNamed:@"scan"];
    }else {
        imageViewScan.image = [UIImage imageNamed:@"scan480"];
    }
    
    imageViewScan.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageViewScan];

    self.imageViewScan = imageViewScan;
    
    
    self.line = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.line.image = [UIImage imageNamed:@"kuaidiyuan_scanner"];
    [imageViewScan addSubview:self.line];
    
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


-(void)doNavEventBack:(id)sender
{
    [self.camerView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
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
        [self sureCourierArrive];
        break;
    }
    if(!symbol)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"系统未发现二维码,请您继续扫描" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
///确认送达
-(void)sureCourierArrive
{
    [self.camerView stop];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:codeMessage forKey:@"express_no"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]courierArrivedWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [self.camerView start];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (model.responseCode ==ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"已确认送达"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [self.camerView start];
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
