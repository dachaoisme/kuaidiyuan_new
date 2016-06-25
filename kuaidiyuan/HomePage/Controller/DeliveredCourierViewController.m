//
//  DeliveredCourierViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "DeliveredCourierViewController.h"
#import "DeliveredCourierTableViewCell.h"
#import "CourierModel.h"

@interface DeliveredCourierViewController ()<UITableViewDelegate,UITableViewDataSource,DeliveredCourierTableViewCellDelegate>
{
    NSMutableArray * courierInfoModelArr;
    NSInteger pageNum;
    NSInteger pageSize;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation DeliveredCourierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    courierInfoModelArr = [NSMutableArray array];
    pageNum = 1;
    pageSize = 10;
    
    [self createTableView];
    [self requestData];
}

#pragma mark - 创建tableView
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //注册cell
    
    [tableView registerNib:[UINib nibWithNibName:@"DeliveredCourierTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return courierInfoModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DeliveredCourierTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.tag = indexPath.row;
    CourierInfoModel  *model = [courierInfoModelArr objectAtIndex:indexPath.row];
    
    cell.phoneLabel.text = model.courierInfoTelephone;
    cell.timeLabel.text = model.courierCreateTime;
    cell.titleLabel.text = [NSString stringWithFormat:@"%@ 订单号：%@",model.courierInfoCompany,model.courierInfoNum];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}
-(void)requestData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    /*
     courier_id      int     必需      快递员序号
     status          int     非必需     状态 1已送达 0未送达
     page            int     非必需     第几页
     size            int     非必需     每页多少条
     
     */
    [dic setValue:[UserAccountManager sharedInstance].userCourierId forKey:@"courier_id"];
    [dic setValue:@"1" forKey:@"status"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [[HttpClient sharedInstance]expressHistoryWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [self.tableView.footer endRefreshing];
        if (responseModel.responseCode==ResponseCodeSuccess) {
            NSArray * dicArr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * dic in dicArr) {
                CourierInfoModel *expressInfoModel = [[CourierInfoModel alloc] initWithDic:dic];
                [courierInfoModelArr addObject:expressInfoModel];
            }
            ///处理上拉加载更多逻辑
            if (pageNum>=[pageModel.responsePageTotalCount integerValue]) {
                //说明是最后一张
                self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
            }
            [self.tableView reloadData];
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
}
-(void)requestMoreData
{
    pageNum = pageNum+1;
    [self requestData];
}
#pragma mark - 代理方法
- (void)callWithIndex:(NSInteger)index{
    CourierInfoModel  *model = [courierInfoModelArr objectAtIndex:index];
    if (model.courierInfoTelephone.length>0) {
        [CommonUtils callServiceWithTelephoneNum:model.courierInfoTelephone];
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
