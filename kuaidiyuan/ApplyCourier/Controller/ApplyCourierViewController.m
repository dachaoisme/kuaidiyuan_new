//
//  ApplyCourierViewController.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/15.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "ApplyCourierViewController.h"

#import "ApplyCourierTableViewCell.h"
#import "ApplyCourierTwoTableViewCell.h"

@interface ApplyCourierViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ApplyCourierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //校内快递员
    
    self.navigationItem.title = @"我的认证信息";
    
    [self createLeftBackNavBtn];
    //创建tableView
    [self createTableView];
}

#pragma mark - 创建滚动视图列表
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    //发布按钮的创建
    
    float space = 16;
    float btnHeight = 44;
    float footViewHeight = 48;
    float btnWidth = SCREEN_WIDTH - 30;
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footViewHeight)];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"保存" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [submitBtn setFrame:CGRectMake(space, space, btnWidth,btnHeight)];
    submitBtn.layer.cornerRadius = 10.0;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn addTarget:self action:@selector(SubmitApplication) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:submitBtn];
    
    tableView.tableFooterView = backGroundView;

    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"ApplyCourierTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    
     [tableView registerNib:[UINib nibWithNibName:@"ApplyCourierTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
}


#pragma mark - 提交申请按钮
- (void)SubmitApplication{
    
    [CommonUtils showToastWithStr:@"保存"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2 || indexPath.row == 3) {
        
        ApplyCourierTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.row == 2) {
            
            cell.contentLabel.textColor = [UIColor blackColor];
            cell.contentLabel.text = @"吉林大学";
            
        }else{
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.titleLabel.text = @"年级";
            cell.notChangeLabel.hidden = YES;
            
        }
        
        return cell;
        
        
        
    }else{
        
        ApplyCourierTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.row) {
            case 0:{
                
                cell.titleLabel.text = @"真实姓名";
            }
                
                break;
            case 1:{
                
                cell.titleLabel.text = @"身份证号";
            }
                
                break;
            case 4:{
                
                cell.titleLabel.text = @"专业";
            }
                
                break;
            case 5:{
                
                cell.titleLabel.text = @"学号";
            }
                
                break;
                
                
            default:
                break;
        }
        
        return cell;

        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 3) {
        [CommonUtils showToastWithStr:@"请选择年级"];
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
