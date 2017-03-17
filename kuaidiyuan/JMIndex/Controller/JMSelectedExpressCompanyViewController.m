//
//  JMSelectedExpressCompanyViewController.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMSelectedExpressCompanyViewController.h"
#import "InformGetCourierViewController.h"
@interface JMSelectedExpressCompanyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * dataArr;
    NSMutableArray * expressIdArr;
}
@property(nonatomic,strong)UITableView    *tableView;

@end

@implementation JMSelectedExpressCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"选择配送公司"];
    [self createLeftBackNavBtn];
    [self initContentView];
    dataArr = [NSMutableArray array];
    expressIdArr = [NSMutableArray array];
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
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

-(void)requestData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [[HttpClient sharedInstance]selectedCourierCompanyWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSDictionary * tempDic = (NSDictionary *)model.responseCommonDic;
        NSArray * keyArray = [tempDic.allKeys sortedArrayUsingSelector:@selector(compare:)];;
        for (NSString * key in keyArray) {
            [dataArr addObject:[tempDic objectForKey:key]];
            [expressIdArr addObject:key];
        }
        
        
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        
    }];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //目的地
    NSString * cellResuable = @"cell";//[NSString stringWithFormat:@"cell%d",indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellResuable];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellResuable];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [dataArr objectAtIndex:indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.callBackBlock([dataArr objectAtIndex:indexPath.row]);
    //[self.navigationController popViewControllerAnimated:NO];
    [self pushToScanPageWithIndex:indexPath];
}
-(void)pushToScanPageWithIndex:(NSIndexPath *)indexPath
{
    InformGetCourierViewController *informVC = [[InformGetCourierViewController alloc] init];
    informVC.ruHuoType = self.ruHuoType;
    informVC.expressName = [dataArr objectAtIndex:indexPath.row];
    informVC.expressId = [expressIdArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:informVC animated:YES];
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
