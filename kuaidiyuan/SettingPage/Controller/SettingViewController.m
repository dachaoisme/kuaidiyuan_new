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

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    [self createLeftBackNavBtn];
    [self createTableView];
    [self requestData];
}

#pragma mark - 创建滚动视图列表
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    
    
    //退出登录按钮
    UIButton *existButton = [UIButton buttonWithType:UIButtonTypeCustom];
    existButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
    existButton.backgroundColor = [UIColor whiteColor];
    [existButton setTitleColor:[CommonUtils colorWithHex:@"ff6478"] forState:UIControlStateNormal];
    [existButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [existButton addTarget:self action:@selector(existAction) forControlEvents:UIControlEventTouchUpInside];
    tableView.tableFooterView = existButton;

}

#pragma mark - 退出按钮的响应方法
- (void)existAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要退出登录？" message:@"\n" preferredStyle:UIAlertControllerStyleAlert];
    
    //这跟 actionSheet有点类似了,因为都是UIAlertController里面的嘛
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UserAccountManager sharedInstance]exitLogin];
        
        //触发AppDelegate中的
    
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate setRootViewController];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    //添加按钮
    [alert addAction:ok];
    [alert addAction:cancel];
    //以modal的方式来弹出
    [self presentViewController:alert animated:YES completion:^{ }];
}



#pragma mark - UITableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"工作统计";
        cell.contentLabel.text = [NSString stringWithFormat:@"本月收%@件,送%@件",[UserAccountManager sharedInstance].userReceiveCourierNumber,[UserAccountManager sharedInstance].userSendCourierNumber];//@"陈奕迅";
        
        
    }else if (indexPath.row == 1){
        
        cell.titleLabel.text = @"我的认证信息";
        cell.contentLabel.text = [UserAccountManager sharedInstance].userName;//@"陈奕迅";
        
    }else{
        
        cell.titleLabel.text = @"我的手机号";
        cell.contentLabel.text = [UserAccountManager sharedInstance].userTelphone;//@"13782947392";
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        //工作统计
        
        if (1/*[UserAccountManager sharedInstance].userCourierRoleType == CourierRoleTypeOfSchool/*) {

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
        
      if (1/*[UserAccountManager sharedInstance].userCourierRoleType == CourierRoleTypeOfSchool*/) {
          
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

-(void)requestData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].user_id forKey:@"id"];
    [[HttpClient sharedInstance]statisticsCourierHistoryWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            NSString * sendCnt = [model.responseCommonDic stringForKey:@"sendCnt"];
            NSString * receiveCnt = [model.responseCommonDic stringForKey:@"receiveCnt"];
            [UserAccountManager sharedInstance].userSendCourierNumber = sendCnt;
            [UserAccountManager sharedInstance].userReceiveCourierNumber =receiveCnt;
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
        [self.tableView reloadData];
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
