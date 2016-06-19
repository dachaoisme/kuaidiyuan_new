//
//  OutsideSchoolCourierViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/19.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "OutsideSchoolCourierViewController.h"

#import "OutsideSchooleTableViewCell.h"

@interface OutsideSchoolCourierViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OutsideSchoolCourierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的认证信息";
    
    [self createLeftBackNavBtn];
    //创建tableView
    [self createTableView];
}

#pragma mark - 创建滚动视图列表
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    
    [self.view addSubview:tableView];
    
    
    float space = 16;
    float btnHeight = 44;
    float footViewHeight = 48;
    float btnWidth = SCREEN_WIDTH - 30;
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footViewHeight)];
    

    
    UILabel *showAlertLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, 0, 200, 30)];
    showAlertLabel.textAlignment = NSTextAlignmentCenter;
    showAlertLabel.font = [UIFont systemFontOfSize:14];
    showAlertLabel.textColor = [UIColor lightGrayColor];
    showAlertLabel.text = @"如需修改请联系学院派工作人员";
    [backGroundView addSubview:showAlertLabel];
    
    
    tableView.tableFooterView = backGroundView;
    
    
    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"OutsideSchooleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OutsideSchooleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:{
            
            cell.titleLabel.text = @"姓名";
            cell.contentLabel.text = @"张三";
            cell.showImageView.hidden = YES;
        }
            
            break;
        case 1:{
            
            cell.titleLabel.text = @"身份证号";
            
        }
            
            break;
        case 2:{
            
            cell.titleLabel.text = @"快递公司";
            cell.contentLabel.text = @"圆通";
            cell.showImageView.hidden = YES;
        }
            
            break;
        case 3:{
            
            cell.titleLabel.text = @"配送学校";
            cell.contentLabel.text = @"吉林大学";
            cell.showImageView.hidden = YES;
        }
            
            break;
            
            
        default:
            break;
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
