//
//  SelectedCourierCompanyViewController.m
//  kuaidiyuan
//
//  Created by lidachao on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SelectedCourierCompanyViewController.h"

@interface SelectedCourierCompanyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * dataArr;
    NSInteger pageNum;
    NSInteger pageSize;
}
@property(nonatomic,strong)UITableView    *tableView;
@end

@implementation SelectedCourierCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"请选择配送公司"];
    [self createLeftBackNavBtn];
    [self initContentView];
    dataArr = [NSMutableArray array];
    pageNum = 10;
    pageSize = 1;
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
    [dic setObject:[NSString stringWithFormat:@"%ld",pageNum] forKey:@"size"];
    [dic setObject:[NSString stringWithFormat:@"%ld",pageSize] forKey:@"page"];
    [[HttpClient sharedInstance]selectedCourierCompanyWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSArray * dicArr = (NSArray *)model.responseCommonDic;
        [dataArr addObjectsFromArray:dicArr];
        
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
    [self.navigationController popViewControllerAnimated:YES];
    
}- (void)didReceiveMemoryWarning {
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
