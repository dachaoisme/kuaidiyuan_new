//
//  DeliveryRecordViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "DeliveryRecordViewController.h"
#import "DeliveryRecordHeaderView.h"

#import "DeliveredCourierViewController.h"
#import "UndeliveredCourierViewController.h"
#import "DeliveredCourierViewController.h"

@interface DeliveryRecordViewController () <DeliveryRecordHeaderViewDelegate>
{
    UndeliveredCourierViewController *undeliverVC;
    
    DeliveredCourierViewController *deliveryVC;
}

///设置头部选项卡视图
@property (nonatomic,strong)DeliveryRecordHeaderView *headerView;
///用于记录点击的是哪个选项卡
@property (nonatomic,assign)NSInteger index;


@end

@implementation DeliveryRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"送快递记录";
    
    [self createLeftBackNavBtn];
    
    //创建headerView的两个选项框
    [self createHeaderView];

}

#pragma mark - 创建headerView
- (void)createHeaderView{
    
    NSArray *arrar = [NSArray arrayWithObjects:@"未送达",@"已送达", nil];
    UIView *backGroundHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, [UIScreen mainScreen].bounds.size.width, 50)];
    backGroundHeaderView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backGroundHeaderView];
    
    DeliveryRecordHeaderView *headerView = [[DeliveryRecordHeaderView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, 0, 200, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.delegate = self;
    headerView.type = PiecewiseInterfaceTypeMobileLin;
    headerView.textFont = [UIFont systemFontOfSize:14];
    headerView.textNormalColor = [CommonUtils colorWithHex:@"666666"];
    headerView.textSeletedColor = [CommonUtils colorWithHex:@"00BEAF"];
    headerView.linColor = [CommonUtils colorWithHex:@"00BEAF"];
    [headerView loadTitleArray:arrar];
    [backGroundHeaderView addSubview:headerView];
    self.headerView = headerView;
    
    
    undeliverVC = [[UndeliveredCourierViewController alloc]init];
    undeliverVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
    undeliverVC.view.backgroundColor = [UIColor redColor];
    undeliverVC.view.hidden = NO;
    undeliverVC.superViewController = self;
    [self.view addSubview:undeliverVC.view];

}

#pragma mark - UniversityAssnHeaderViewDelegate代理方法
#pragma mark - 点击每个选项卡响应的方法
- (void)headerViewSelctAction:(DeliveryRecordHeaderView *)headerView index:(NSInteger)index{
    
    self.index = index;
    
    switch (index) {
        case 0:
        {
            //未送达
            if (!undeliverVC) {
                undeliverVC = [[UndeliveredCourierViewController alloc]init];
                undeliverVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                undeliverVC.view.hidden = YES;
                undeliverVC.superViewController = self;
                [self.view addSubview:undeliverVC.view];
            }
            
            undeliverVC.view.hidden = NO;
            deliveryVC.view.hidden = YES;
        }
            break;
        case 1:
        {
            //已送达
            if (!deliveryVC) {
                deliveryVC = [[DeliveredCourierViewController alloc]init];
                deliveryVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                deliveryVC.view.hidden = YES;
                deliveryVC.superViewController = self;
                [self.view addSubview:deliveryVC.view];
            }
            undeliverVC.view.hidden = YES;
            deliveryVC.view.hidden = NO;
        }
            break;
            
        default:
            break;
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
