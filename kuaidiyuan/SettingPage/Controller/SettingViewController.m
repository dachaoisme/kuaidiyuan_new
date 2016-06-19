//
//  SettingViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SettingViewController.h"

#import "SettingTableViewCell.h"

#import "ApplyCourierViewController.h"
#import "OutsideSchoolCourierViewController.h"

#import "BindPhoneViewController.h"

#import "InSchoolCourierJobListViewController.h"
#import "OutsideSchoolJobListViewController.h"

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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        //工作统计
        
        if ([UserAccountManager sharedInstance].userCourierRoleType == CourierRoleTypeOfSchool) {

            //校内快递员
            InSchoolCourierJobListViewController *inSchoolVC = [[InSchoolCourierJobListViewController alloc] init];
            [self.navigationController pushViewController:inSchoolVC animated:YES];
            

            
        }else{
            
            //校外快递员
            OutsideSchoolJobListViewController *outsideSchoolVC = [[OutsideSchoolJobListViewController alloc] init];
            
            [self.navigationController pushViewController:outsideSchoolVC animated:YES];
        }

        
        
        

        
    }else if (indexPath.row == 1){
        //我的认证信息
        
#warning 需要进行判断跳转是校内快递员还是校外快递员
        
      if ([UserAccountManager sharedInstance].userCourierRoleType == CourierRoleTypeOfSchool) {
          
          //校内快递员
          ApplyCourierViewController *applyCourierVC = [[ApplyCourierViewController alloc] init];
          [self.navigationController pushViewController:applyCourierVC animated:YES];
      }else{
          //校外快递员
          OutsideSchoolCourierViewController *outsideSchoolVC = [[OutsideSchoolCourierViewController alloc] init];
          [self.navigationController pushViewController:outsideSchoolVC animated:YES];
      }
        
    }else{
        //跳转修改手机号绑定
        BindPhoneViewController *bindPhoneVC = [[BindPhoneViewController alloc] init];
        [self.navigationController pushViewController:bindPhoneVC animated:YES];
        
        
        
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
