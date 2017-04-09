//
//  JMWorkStatisticsViewController.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/21.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMWorkStatisticsViewController.h"
#import "RCSegmentView.h"
#import "JMWorkStatisticDetailViewController.h"
@interface JMWorkStatisticsViewController ()
{
    RCSegmentView *segmentView;
}
@end

@implementation JMWorkStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createLeftBackNavBtn];
    self.title  =@"工作统计";
    [self setCntentView];
    
}
-(void)setCntentView
{
    NSMutableArray *controllerVCArr = [NSMutableArray array];
    NSArray *titelArr = [NSArray arrayWithObjects:@"历史",@"本月",@"上月", nil];
    for (int i=0; i<3; i++) {
        JMWorkStatisticDetailViewController * workDetailVC = [[JMWorkStatisticDetailViewController alloc] init];
        workDetailVC.timeType = i;
        [controllerVCArr addObject:workDetailVC];
    }
    segmentView = [[RCSegmentView alloc]initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_TOP_HEIGHT) controllers:controllerVCArr titleArray:titelArr ParentController:self];
    [self.view addSubview:segmentView];
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
