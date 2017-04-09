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
@interface JMWorkStatisticDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * dataArr;
}
@property(nonatomic,strong)UITableView    *tableView;
@end

@implementation JMWorkStatisticDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    dataArr = [NSMutableArray array];
    [self initContentView];
    
    [self requestData];
    
}
-(void)initContentView
{
    //初始化tableView
    CGRect rc = self.view.bounds;
    rc.origin.y = 0;
    rc.size.height = SCREEN_HEIGHT-NAV_TOP_HEIGHT;
    
    UITableView * tableView    = [[UITableView alloc]initWithFrame:rc style:UITableViewStylePlain];
    tableView.separatorColor  = [CommonUtils colorWithHex:@"eeeeee"];
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource       = self;
    tableView.delegate         = self;
    tableView.backgroundColor = [UIColor yellowColor];
    tableView.separatorColor = [CommonUtils colorWithHex:@"f4f4f4"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

-(void)requestData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@"month" forKey:@"frequency"];
    [dic setObject:@"2017-03"/*[CommonUtils getCurrenttime]*/ forKey:@"time"];
    [dic setObject:[UserAccountManager sharedInstance].user_id forKey:@"user_id"];
    [[HttpClient sharedInstance]getWorkDetailStaticWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
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
