//
//  UndeliveredCourierViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "UndeliveredCourierViewController.h"

#import "CourierHomePageTwoTableViewCell.h"

@interface UndeliveredCourierViewController ()<UITableViewDataSource,UITableViewDelegate,CourierHomePageTwoTableViewCellDelegate>

@end

@implementation UndeliveredCourierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self createTableView];
}

#pragma mark - 创建tableView
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"CourierHomePageTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourierHomePageTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

#pragma mark - cell中的三个按钮的响应方法
- (void)confirmDelivery{
    
    [CommonUtils showToastWithStr:@"确认送达"];
    
}

- (void)resendMessage{
    
    [CommonUtils showToastWithStr:@"重发短信"];
}

- (void)call{
    [CommonUtils showToastWithStr:@"打电话"];
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
