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

#import "CampusCourierHomePageTableViewCell.h"

#import "DeliveryRecordViewController.h"
#import "CourierMessageViewController.h"

#import "QRScanViewController.h"


@interface CourierHomePageViewController ()<UITableViewDataSource,UITableViewDelegate,CourierHomePageTwoTableViewCellDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation CourierHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //校内快递员界面
    
    self.title = @"学院派快递员";
    
    [self creatLeftNavWithImageName:@"nav_icon_settings"];
    
    
    [self createTableView];
    
    
    [self createFootView];
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
    

     [tableView registerNib:[UINib nibWithNibName:@"CampusCourierHomePageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"threeCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        
        return 2;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        CampusCourierHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        

        return cell;

    }else if(indexPath.section == 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];

        if (indexPath.row == 0) {
            cell.textLabel.text = @"全部送快递记录";

        }else{
            cell.textLabel.text = @"取件消息";

        }
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
            
            
            return cell;
            
            
        }

    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2  && indexPath.row > 0) {
        return 120;
    }else{
        return 49;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //送快递记录
            DeliveryRecordViewController *recordVC = [[DeliveryRecordViewController alloc] init];
            [self.navigationController pushViewController:recordVC animated:YES];
        }else{
            //取件消息记录
            CourierMessageViewController *messageVC = [[CourierMessageViewController alloc] init];
            [self.navigationController pushViewController:messageVC animated:YES];
            
        }
    }
}


#pragma mark - cell中的三个按钮的响应方法
- (void)confirmDelivery{
    
    [CommonUtils showToastWithStr:@"确认送达"];
    
}

- (void)resendMessage{
    
    [CommonUtils showToastWithStr:@"重发短信"];
}

- (void)call{
    [CommonUtils showToastWithStr:@"打电话"];
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
    [dic setValue:@"1" forKey:@"working"];
    
    [[HttpClient sharedInstance]configureWorkTimeWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            ///设置成功
            [CommonUtils showToastWithStr:@"设置成功"];
        }else{
            ///设置失败失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [CommonUtils showToastWithStr:@"请检查您的网络"];
    }];
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
