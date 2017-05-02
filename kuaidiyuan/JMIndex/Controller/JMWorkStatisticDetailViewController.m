//
//  JMWorkStatisticDetailViewController.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/4/9.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMWorkStatisticDetailViewController.h"
#import "JMWorkStautsModel.h"
#import "JMWorkStatisticTableViewCell.h"
#import "JMWorkStatisticHeadView.h"
@interface JMWorkStatisticDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * dataArr;
    JMWorkStatisticHeadView  * headView;
    ///上面的header部分
    JMWorkStautsModel *headerWorkStatusModel;
}
@property(nonatomic,strong)UITableView    *tableView;
@end

@implementation JMWorkStatisticDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    dataArr = [NSMutableArray array];
    [self initContentView];
    
    [self requestData];
    [self requestHeadView];
    
}
-(void)initContentView
{
    //初始化tableView
    CGRect rc = self.view.bounds;
    rc.origin.y = 0;
    rc.size.height = SCREEN_HEIGHT-NAV_TOP_HEIGHT;
    
    UITableView * tableView    = [[UITableView alloc]initWithFrame:rc style:UITableViewStyleGrouped];
    tableView.separatorColor  = [CommonUtils colorWithHex:@"eeeeee"];
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource       = self;
    tableView.delegate         = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorColor = [CommonUtils colorWithHex:@"f4f4f4"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    headView = [[JMWorkStatisticHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 148)];
    tableView.tableHeaderView = headView;
}
-(void)refreshHeadView
{
    
    headView.todayIncomeStorageCountLabel.text =[NSString stringWithFormat:@"%@件",headerWorkStatusModel.workStautsOfRukuCnt] ;
    headView.todayIncomeRackCountLabel.text = [NSString stringWithFormat:@"%@件",headerWorkStatusModel.workStautsOfRuguojiaCnt];
    headView.todayIncomeCupboardCountLabel.text = [NSString stringWithFormat:@"%@件",headerWorkStatusModel.workStautsOfRuguiCnt];
    headView.todayClockTimeLabel.text =[NSString stringWithFormat:@"%@",headerWorkStatusModel.workStautsOfTime_len];
}
-(void)requestData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    if (self.timeType==0) {
        //[dic setObject:@"month" forKey:@"frequency"];
        //[dic setObject:[CommonUtils getCurrenttime] forKey:@"time"];
    }else if (self.timeType==1){
        [dic setObject:@"month" forKey:@"frequency"];
        [dic setObject:[CommonUtils getYearAndMonthSinceNowWithLaterDays:@"0"] forKey:@"time"];
    }else{
        [dic setObject:@"month" forKey:@"frequency"];
        [dic setObject:[CommonUtils getYearAndMonthSinceNowWithLaterDays:@"30"] forKey:@"time"];
    }
    
    
    [dic setObject:[UserAccountManager sharedInstance].user_id forKey:@"user_id"];
    [[HttpClient sharedInstance]getWorkDetailStaticWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess &&[model.responseCommonDic isKindOfClass:[NSDictionary class]]) {
            NSArray *modelKeyArray = [model.responseCommonDic allKeys];
            for (NSString *key in modelKeyArray ) {
                NSDictionary * dic = [model.responseCommonDic objectForKey:key];
                JMWorkStautsModel *workStatusModel =[[JMWorkStautsModel alloc] initWithDic:dic];
                workStatusModel.workStautsOfTime = key;
                [dataArr addObject:workStatusModel];
            }
            
            [self.tableView reloadData];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
    
    
}
-(void)requestHeadView
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    if (self.timeType==0) {
        //[dic setObject:@"month" forKey:@"frequency"];
        //[dic setObject:[CommonUtils getCurrenttime] forKey:@"time"];
    }else if (self.timeType==1){
        [dic setObject:@"month" forKey:@"frequency"];
        [dic setObject:[CommonUtils getYearAndMonthSinceNowWithLaterDays:@"0"] forKey:@"time"];
    }else{
        [dic setObject:@"month" forKey:@"frequency"];
        [dic setObject:[CommonUtils getYearAndMonthSinceNowWithLaterDays:@"30"] forKey:@"time"];
    }
    
    [dic setObject:[UserAccountManager sharedInstance].user_id forKey:@"user_id"];
    [[HttpClient sharedInstance]getWorkStatusWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            headerWorkStatusModel =[[JMWorkStautsModel alloc] initWithDic:model.responseCommonDic];
            [self refreshHeadView];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = [CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //目的地
    NSString * cellResuable = @"cell";
    JMWorkStatisticTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellResuable];
    if (!cell) {
        cell = [[JMWorkStatisticTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellResuable];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    JMWorkStautsModel *workStatusModel =[dataArr objectAtIndex:indexPath.row];
    cell.timeTitleLabel.text = workStatusModel.workStautsOfTime;
    cell.contentTitleLabel.text = [NSString stringWithFormat:@"入库：%@件   入货架：%@件  入柜%@件",workStatusModel.workStautsOfRukuCnt,workStatusModel.workStautsOfRuguojiaCnt,workStatusModel.workStautsOfRuguiCnt];
    cell.clockTimeLabel.text = [NSString stringWithFormat:@"打卡时长%@",workStatusModel.workStautsOfTime_len];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
