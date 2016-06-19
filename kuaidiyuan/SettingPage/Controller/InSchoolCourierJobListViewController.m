//
//  InSchoolCourierJobListViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/19.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "InSchoolCourierJobListViewController.h"
#import "InSchoolTableViewCell.h"

@interface InSchoolCourierJobListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic) CGPoint inputPoint0;
@property (nonatomic) CGPoint inputPoint1;

@property (nonatomic) UIColor *inputColor0;
@property (nonatomic) UIColor *inputColor1;

///收件数量
@property (nonatomic,strong)UILabel *receiptNumberLabel;

///送件数量
@property (nonatomic,strong)UILabel *sendNumberLabel;





@end

@implementation InSchoolCourierJobListViewController

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
    UILabel *storyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH /2 - 40, 10, 80, 30)];
    storyLabel.textAlignment = NSTextAlignmentCenter;
    storyLabel.text = @"历史统计";
    storyLabel.font = [UIFont systemFontOfSize:20];
    storyLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:storyLabel];
    
    //创建左侧背景视图
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(storyLabel.frame), SCREEN_WIDTH/2-1, 60)];
    [headerView addSubview:leftView];
    
    //创建中间的竖线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) + 1, CGRectGetMinY(leftView.frame), 1, 60)];
    lineView.backgroundColor = [CommonUtils colorWithHex:@"cccccc"];
    [headerView addSubview:lineView];
    
    //创建右侧视图
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame), CGRectGetMinY(leftView.frame), SCREEN_WIDTH/2, 60)];
    
    [headerView addSubview:rightView];
    
    
    
    //创建左侧视图的两个label
    UILabel *receiptLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(leftView.frame) / 2 - 30, 11, 60, 14)];
    receiptLabel.font = [UIFont systemFontOfSize:14];
    receiptLabel.text = @"收件";
    receiptLabel.textAlignment = NSTextAlignmentCenter;
    receiptLabel.textColor = [UIColor whiteColor];
    [leftView addSubview:receiptLabel];
    
    
    //创建金额的label
    UILabel *receiptNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(receiptLabel.frame), CGRectGetMaxY(receiptLabel.frame)+5, CGRectGetWidth(receiptLabel.frame), 30)];
    receiptNumberLabel.font = [UIFont systemFontOfSize:22];
    receiptNumberLabel.text = @"285";
    receiptNumberLabel.textAlignment = NSTextAlignmentCenter;
    receiptNumberLabel.textColor = [UIColor whiteColor];
    [leftView addSubview:receiptNumberLabel];
    self.receiptNumberLabel = receiptNumberLabel;
    

    
    //创建右侧视图的两个label
    UILabel *sendLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(rightView.frame) / 2 - 30, 11, 60, 14)];
    sendLabel.font = [UIFont systemFontOfSize:14];
    sendLabel.text = @"送件";
    sendLabel.textAlignment = NSTextAlignmentCenter;
    sendLabel.textColor = [UIColor whiteColor];
    [rightView addSubview:sendLabel];


    UILabel *sendNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(sendLabel.frame), CGRectGetMaxY(sendLabel.frame)+5, CGRectGetWidth(sendLabel.frame), 30)];
    sendNumberLabel.font = [UIFont systemFontOfSize:22];
    sendNumberLabel.text = @"888";
    sendNumberLabel.textAlignment = NSTextAlignmentCenter;
    sendNumberLabel.textColor = [UIColor whiteColor];
    [rightView addSubview:sendNumberLabel];
    
    
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(receiptLabel.frame), CGRectGetMaxY(lineView.frame) + 10, SCREEN_WIDTH - CGRectGetMinX(receiptLabel.frame) * 2, 14)];
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
