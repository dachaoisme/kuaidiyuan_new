//
//  SettingViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SettingViewController.h"

#import "SettingTableViewCell.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    [self createLeftBackNavBtn];
    
    
    [self createTableView];
}

#pragma mark - 创建滚动视图列表
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    [tableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        
        
        
    }else if (indexPath.row == 1){
        
        cell.titleLabel.text = @"我的认证信息";
        cell.contentLabel.text = @"陈奕迅";
        
    }else{
        
        cell.titleLabel.text = @"我的手机号";
        cell.contentLabel.text = @"13782947392";
        
    }
    
    return cell;
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
