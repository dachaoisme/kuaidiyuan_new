//
//  JMMineViewController.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/19.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMMineViewController.h"
#import "JMWorkStatisticsViewController.h"
#import "JMChangePasswordViewController.h"
@interface JMMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation JMMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  =@"个人中心";
    [self createLeftBackNavBtn];
    [self createTableView];
    
    
}
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableHeaderView = [self headView];
    
    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 44)];
    titleLabel.text = @"全部快件已送达";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:titleLabel];
    if (indexPath.row==0) {
        titleLabel.text = @"工作统计";
    }else{
        titleLabel.text = @"修改密码";
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH  - 25, 10, 10, 17)];
    imageView.image = [UIImage imageNamed:@"arrow"];
    imageView.center =CGPointMake(imageView.center.x, titleLabel.center.y);
    [cell.contentView addSubview:imageView];

    [UIFactory showLineInView:cell color:@"f4f4f4" rect:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        JMWorkStatisticsViewController * staticVC = [[JMWorkStatisticsViewController alloc] init];
        [self.navigationController pushViewController:staticVC animated:YES];
    }else if (indexPath.row==1){
        JMChangePasswordViewController * changePasswordVC = [[JMChangePasswordViewController alloc] init];
        [self.navigationController pushViewController:changePasswordVC animated:YES];
    }else{
        
    }
}
-(UIView *)headView
{
    UIView *tabelHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    tabelHeadView.backgroundColor =[UIColor whiteColor];
    ///头像
    UIImageView *headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-31, 30, 62, 62)];
    headIcon.image = [UIImage imageNamed:@"avatar"];
    headIcon.layer.cornerRadius = 31;
    headIcon.layer.masksToBounds = YES;
    [tabelHeadView addSubview:headIcon];
    
    ///姓名
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headIcon.frame)+10, SCREEN_WIDTH, 44)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = [UserAccountManager sharedInstance].userName;
    [tabelHeadView addSubview:nameLabel];
    
    ///快递员id
    UILabel *expressIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame)+10, SCREEN_WIDTH, 44)];
    expressIdLabel.textAlignment = NSTextAlignmentCenter;
    expressIdLabel.text = [NSString stringWithFormat:@"快递员编号：%@",[UserAccountManager sharedInstance].userName];
    [tabelHeadView addSubview:expressIdLabel];
    
    return tabelHeadView;
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
