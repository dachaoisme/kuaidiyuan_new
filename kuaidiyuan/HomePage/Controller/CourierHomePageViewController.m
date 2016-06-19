//
//  CourierHomePageViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/17.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "CourierHomePageViewController.h"

#import "CourierHomePageOneTableViewCell.h"
#import "CourierHomePageTwoTableViewCell.h"


#import "DeliveryRecordViewController.h"
#import "CourierMessageViewController.h"

#import "QRScanViewController.h"
#import "InformGetCourierViewController.h"

#import "SettingViewController.h"


@interface CourierHomePageViewController ()<UITableViewDataSource,UITableViewDelegate,CourierHomePageTwoTableViewCellDelegate>
{
    NSInteger pageNum;
    NSInteger pageSize;
    NSMutableArray * courierInfoModelArr;
    NSInteger workingSwitchValue;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation CourierHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //校内快递员界面
    
    self.title = @"学院派快递员";
    courierInfoModelArr = [NSMutableArray array];
    [self creatLeftNavWithImageName:@"nav_icon_settings"];
    pageNum = 0;
    pageSize = 10;
    workingSwitchValue = 1;
    [self createTableView];
    [self createFootView];
    [self requestData];
    
    
    //校内快递员不隐藏
    if ([UserAccountManager sharedInstance].userCourierRoleType == CourierRoleTypeOfSchool) {
        
        //根据判断是否隐藏headerView
        [self createHeaderView];

        
        self.tableView.tableHeaderView.hidden = NO;

        
    }else{
        
        //校外快递员隐藏
        self.tableView.tableHeaderView.hidden = YES;
    }
    
    
}


#pragma mark - 创建区分校内快递员还是校外快递员的headerView
- (void)createHeaderView{
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49*2+10)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = backGroundView;
    
    
    //第一行View:上班接单中
    UIView *lineOneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    [backGroundView addSubview:lineOneView];
    
    
    UILabel *workingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 13, 70, 20)];
    workingLabel.font = [UIFont systemFontOfSize:14];
    workingLabel.text = @"上班接单中";
    [lineOneView addSubview:workingLabel];
    
    
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(workingLabel.frame) + 5, CGRectGetMinY(workingLabel.frame), 160, 20)];
    alertLabel.font = [UIFont systemFontOfSize:14];
    alertLabel.textColor = [UIColor lightGrayColor];
    alertLabel.text = @"(打开开关获得取件订单)";
    [lineOneView addSubview:alertLabel];
    
    
    UISwitch *isOpenSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, CGRectGetMinY(workingLabel.frame) - 5, 50, CGRectGetHeight(alertLabel.frame))];
    [isOpenSwitch addTarget:self action:@selector(getSwitchValue:) forControlEvents:UIControlEventValueChanged];
    [lineOneView addSubview:isOpenSwitch];
    
    
    
    //空格view
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineOneView.frame), SCREEN_WIDTH, 10)];
    grayView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [backGroundView addSubview:grayView];
    
    
    
    //第二行view
    UIView *lineTwoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(grayView.frame), SCREEN_WIDTH, 49)];
    [backGroundView addSubview:lineTwoView];
    
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 13, 70, 20)];
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.text = @"取件消息";
    [lineTwoView addSubview:messageLabel];


    //右侧箭头
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 25, 15, 10, 17)];
    arrowImageView.image = [UIImage imageNamed:@"arrow"];
    [lineTwoView addSubview:arrowImageView];
    
    
    UITapGestureRecognizer *tapMessageAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageList)];
    [lineTwoView addGestureRecognizer:tapMessageAction];
    
    
}

#pragma mark - 开关打开的响应时间
- (void)getSwitchValue:(UISwitch *)sender{
    
    if (sender.isOn) {
        [CommonUtils showToastWithStr:@"开"];
        workingSwitchValue = 1;
    }else{
        workingSwitchValue = 0;
        [CommonUtils showToastWithStr:@"关"];
    }
    [self configureCouriserWorkTime];
}


#pragma mark - 创建底层浮层
- (void)createFootView{
    
    UIButton *informGetCourierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [informGetCourierBtn setTitle:@"通知取快递" forState:UIControlStateNormal];
    [informGetCourierBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [informGetCourierBtn addTarget:self action:@selector(informGetCourierAction) forControlEvents:UIControlEventTouchUpInside];
    informGetCourierBtn.layer.cornerRadius = 6;
    informGetCourierBtn.layer.masksToBounds = YES;
    informGetCourierBtn.frame = CGRectMake(15, SCREEN_HEIGHT - 60, (SCREEN_WIDTH - 40)/2, 50);
    informGetCourierBtn.backgroundColor = [UIColor colorWithRed:250/255.0 green:127/255.0 blue:58/255.0 alpha:0.8];
    [self.view addSubview:informGetCourierBtn];
    
    
    UIButton *scanConfirmDelayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanConfirmDelayBtn setTitle:@"扫一扫确认送达" forState:UIControlStateNormal];
    scanConfirmDelayBtn.layer.cornerRadius = 6;
    scanConfirmDelayBtn.layer.masksToBounds = YES;
    [scanConfirmDelayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scanConfirmDelayBtn addTarget:self action:@selector(scanConfirmDelayAction) forControlEvents:UIControlEventTouchUpInside];

    scanConfirmDelayBtn.frame = CGRectMake(CGRectGetMaxX(informGetCourierBtn.frame) + 10, SCREEN_HEIGHT - 60, (SCREEN_WIDTH - 40)/2, 50);
    scanConfirmDelayBtn.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [self.view addSubview:scanConfirmDelayBtn];
}

#pragma mark - 通知去快递
- (void)informGetCourierAction{
    
    InformGetCourierViewController *informVC = [[InformGetCourierViewController alloc] init];
    [self.navigationController pushViewController:informVC animated:YES];
    
}

#pragma mark - 扫一扫确认送达
- (void)scanConfirmDelayAction{
    
    QRScanViewController *scanVC = [[QRScanViewController alloc] init];
    [self.navigationController pushViewController:scanVC animated:YES];
    
}

- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 70) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    

    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:@"CourierHomePageOneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"CourierHomePageTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
    [tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        
        return courierInfoModelArr.count+1;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else{
        return 10;

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     if(indexPath.section == 0){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
         
         
         UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 15, 10, 17)];
         arrowImageView.image = [UIImage imageNamed:@"arrow"];
        cell.accessoryView = arrowImageView;
        cell.textLabel.font = [UIFont systemFontOfSize:14];

        cell.textLabel.text = @"全部送快递记录";

        return cell;

        
        
    }else{
        
        if (indexPath.row == 0) {
            
            CourierHomePageOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            return cell;
            
        }else{
            
            CourierHomePageTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            CourierInfoModel  *model = [courierInfoModelArr objectAtIndex:indexPath.row-1];
            cell.phoneLabel.text = model.courierInfoTelephone;
            cell.timeLabel.text = model.courierCreateTime;
            cell.titleLabel.text = [NSString stringWithFormat:@"%@ 订单号：%@",model.courierInfoCompany,model.courierInfoNum];
            
            return cell;
            
            
        }

    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1  && indexPath.row > 0) {
        return 120;
    }else{
        return 49;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        //送快递记录
        DeliveryRecordViewController *recordVC = [[DeliveryRecordViewController alloc] init];
        [self.navigationController pushViewController:recordVC animated:YES];
    }
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
    [dic setValue:@"0" forKey:@"status"];
    [dic setValue:[NSString stringWithFormat:@"%d",(long)pageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
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


#pragma mark - 查看取件消息列表

- (void)messageList{
    //取件消息记录
    CourierMessageViewController *messageVC = [[CourierMessageViewController alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
}


#pragma mark - cell中的三个按钮的响应方法
- (void)confirmDeliveryWithIndex:(NSInteger)index{
    
    [CommonUtils showToastWithStr:@"确认送达"];
    [self sureCourierArriveWithIndex:index];
}
///确认送达
-(void)sureCourierArriveWithIndex:(NSInteger)index
{
    CourierInfoModel *model = [courierInfoModelArr objectAtIndex:index-1];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:model.courierInfoNum forKey:@"express_no"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]courierArrivedWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (model.responseCode ==ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"已确认送达"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
#pragma mark - 冲发短信 还未实现
- (void)resendMessageWithIndex:(NSInteger)index
{
    CourierInfoModel *model = [courierInfoModelArr objectAtIndex:index-1];
    [CommonUtils showToastWithStr:@"重发短信"];
}

- (void)callWithIndex:(NSInteger)index
{
    CourierInfoModel *model = [courierInfoModelArr objectAtIndex:index-1];
    [CommonUtils showToastWithStr:@"打电话"];
    if (model.courierInfoTelephone.length>0) {
        [CommonUtils callServiceWithTelephoneNum:model.courierInfoTelephone];
    }
    
}
#pragma mark - 设置快递员上下班
-(void)configureCouriserWorkTime
{
    /*
     courier_id      int         必需      快递员序号
     working         int         必需      设置上下班 1上班 0下班
     */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userCourierId forKey:@"courier_id"];
    [dic setValue:[NSString stringWithFormat:@"%d",workingSwitchValue] forKey:@"working"];
    
    [[HttpClient sharedInstance]configureWorkTimeWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            ///设置成功
            //[CommonUtils showToastWithStr:@"设置成功"];
        }else{
            ///设置失败失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}


#pragma mark - 设置界面
- (void)leftItemActionWithBtn:(UIButton *)sender{
    
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
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
