//
//  OutsideSchoolJobListViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/19.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "OutsideSchoolJobListViewController.h"

#import "InSchoolTableViewCell.h"

@interface OutsideSchoolJobListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) CGPoint inputPoint0;
@property (nonatomic) CGPoint inputPoint1;

@property (nonatomic) UIColor *inputColor0;
@property (nonatomic) UIColor *inputColor1;


@property (nonatomic,strong)UITableView *tableView;

@end

@implementation OutsideSchoolJobListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工作统计";
    [self createLeftBackNavBtn];
    
    [self createTableView];
}

- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //注册cell
    [tableView registerClass:[InSchoolTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self createTableViewHeaderView];
}

- (void)createTableViewHeaderView{
    
    //设置顶部视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    _inputColor0 = [CommonUtils colorWithHex:@"2eeabd"];
    _inputColor1 = [CommonUtils colorWithHex:@"00beaf"];
    _inputPoint0 = CGPointMake(0, 0);
    _inputPoint1 = CGPointMake(SCREEN_WIDTH, 140);
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[(__bridge id)_inputColor0.CGColor, (__bridge id)_inputColor1.CGColor];
    layer.startPoint = _inputPoint0;
    layer.endPoint = _inputPoint1;
    layer.frame = headerView.bounds;
    [headerView.layer addSublayer:layer];
    self.tableView.tableHeaderView = headerView;
    
    
    //历史总计
    UILabel *storyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH /2 - 60, 20, 120, 30)];
    storyLabel.textAlignment = NSTextAlignmentCenter;
    storyLabel.text = @"历史总计送件";
    storyLabel.font = [UIFont systemFontOfSize:20];
    storyLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:storyLabel];
    
    UILabel *sendNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(storyLabel.frame), CGRectGetMaxY(storyLabel.frame)+5, CGRectGetWidth(storyLabel.frame), 30)];
    sendNumberLabel.font = [UIFont systemFontOfSize:22];
    sendNumberLabel.text = @"888";
    sendNumberLabel.textAlignment = NSTextAlignmentCenter;
    sendNumberLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:sendNumberLabel];
    
    
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(sendNumberLabel.frame) - 50, CGRectGetMaxY(sendNumberLabel.frame) + 10, SCREEN_WIDTH - CGRectGetMinX(sendNumberLabel.frame) * 2 + 100, 14)];
    alertLabel.font = [UIFont systemFontOfSize:14];

    alertLabel.textColor = [UIColor whiteColor];

    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.text = @"代售点送件32件，快递柜送间45件";
    [headerView addSubview:alertLabel];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    InSchoolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.timeLabel.text = @"2015-934-34i";
    cell.contentLabel.text = @"和对市场部还得上班的的";
    
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
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
