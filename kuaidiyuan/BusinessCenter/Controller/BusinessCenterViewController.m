//
//  BusinessCenterViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessCenterViewController.h"




@interface BusinessCenterViewController ()

{
    NSMutableArray * tutorStarModelListArr;
    NSMutableArray * businessProjectModelListArr;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation BusinessCenterViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"创业中心"];
    tutorStarModelListArr = [NSMutableArray array];
    businessProjectModelListArr = [NSMutableArray array];
    //创建导航栏右侧按钮
    [self creatRightNavWithTitle:@"发布项目"];
    
}

#pragma mark - 导航栏右侧按钮的响应方法
-(void)rightItemActionWithBtn:(UIButton *)sender
{
   
    
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
