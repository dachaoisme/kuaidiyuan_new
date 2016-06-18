//
//  CourierMessageViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "CourierMessageViewController.h"
#import "SendCourierRecordTableViewCell.h"

@interface CourierMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageSize;
    NSInteger pageNum;
    NSMutableArray * dataArray;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation CourierMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"取件消息";
    pageNum = 0;
    pageSize =10;
    dataArray = [NSMutableArray array];
    [self createLeftBackNavBtn];
    
    [self createTableView];
    [self requestData];
}

- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"SendCourierRecordTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];

    [tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoerData)];
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SendCourierRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CourierIncompleteMessageModel * model = [dataArray objectAtIndex:indexPath.row];
    [cell bindModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 210;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

-(void)requestData
{

    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%ld",pageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",pageSize] forKey:@"size"];
    [dic setValue:[UserAccountManager sharedInstance].userCourierId forKey:@"courier_id"];
    [[HttpClient sharedInstance]incompleteCourierWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        if (responseModel.responseCode == ResponseCodeSuccess) {
            ///请求成功
            for (NSDictionary *dic in [responseModel.responseCommonDic objectForKey:@"lists"]) {
                CourierIncompleteMessageModel *courierModel = [[CourierIncompleteMessageModel alloc]initWithDic:dic];
                [dataArray addObject:courierModel];
            }
            
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        
    }];
}

-(void)requestMoerData
{
    pageNum = pageNum+1;
    [self requestData];
}
#pragma mark - 打电话

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
