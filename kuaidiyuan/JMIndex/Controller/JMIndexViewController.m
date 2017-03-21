//
//  JMIndexViewController.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/6.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMIndexViewController.h"
#import "JMIndexCollectionViewCell.h"
#import "JMIndexHeadView.h"
#import "JMIndexCollectionReusableView.h"
#import "JMWorkStautsModel.h"
#import "JMSelectedExpressCompanyViewController.h"
#import "InformGetCourierViewController.h"
#import "JMKongGuiViewController.h"
#import "JMMineViewController.h"
@interface JMIndexViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    JMWorkStautsModel *workStatusModel;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation JMIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  =@"集梦盒子快递员";
    [self creatRightNavWithTitle:@"退出登录"];
    [self setupContentView];
    [self requestHeadView];
    
}
#pragma mark - body视图相关
- (void)setupContentView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    ///竖直间距
    float horizontalSpaceing = 0 * VMScaleOfCurrentDeviceAndModelDeviceWidth;
    ///行间距
    float verticalSpaceing = 0 * VMScaleOfCurrentDeviceAndModelDeviceWidth;
    ///行间距
    layout.minimumLineSpacing = verticalSpaceing;
    ///竖行间距
    layout.minimumInteritemSpacing = horizontalSpaceing;
    layout.itemSize = CGSizeMake((self.view.bounds.size.width - horizontalSpaceing * 3.1) / 2, 136 * VMScaleOfCurrentDeviceAndModelDeviceWidth - horizontalSpaceing);
    layout.sectionInset = UIEdgeInsetsMake(verticalSpaceing * VMScaleOfCurrentDeviceAndModelDeviceWidth, horizontalSpaceing, verticalSpaceing, horizontalSpaceing);
    CGRect rect;
    rect = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.view.frame));
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    [self.collectionView registerClass:[JMIndexCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JMIndexCollectionViewCell class])];
    [self.collectionView registerClass:[JMIndexCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - UICollectionViewDataSource
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return sectionInset;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 148 * VMScaleOfCurrentDeviceAndModelDeviceWidth);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //此处是headerView
    if (kind == UICollectionElementKindSectionHeader) {
        JMIndexCollectionReusableView *headReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        JMIndexHeadView * headView = [[JMIndexHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 148*VMScaleOfCurrentDeviceAndModelDeviceWidth)];
        headView.todayIncomeStorageCountLabel.text =[NSString stringWithFormat:@"%@件",workStatusModel.workStautsOfRukuCnt] ;
        headView.todayIncomeRackCountLabel.text = [NSString stringWithFormat:@"%@件",workStatusModel.workStautsOfRuguojiaCnt];
        headView.todayIncomeCupboardCountLabel.text = [NSString stringWithFormat:@"%@件",workStatusModel.workStautsOfRuguiCnt];;
        [headReusableView addSubview:headView];
        return headReusableView;
    } else {
        return nil;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JMIndexCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JMIndexCollectionViewCell class]) forIndexPath:indexPath];
    if (indexPath.row==0) {
        cell.titelLable.text =@"快递入库";
        cell.icon.image = [UIImage imageNamed:@"home_ruku"];
    }else if (indexPath.row==1){
        cell.titelLable.text =@"快递入货架";
        cell.icon.image = [UIImage imageNamed:@"home_huojia"];
    }else if (indexPath.row==2){
        cell.titelLable.text =@"空柜状态";
        cell.icon.image = [UIImage imageNamed:@"konggui"];
    }else{
        cell.titelLable.text =@"个人中心";
        cell.icon.image = [UIImage imageNamed:@"home_user"];
    }
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RuHuoType ruHuoType ;
    if (indexPath.row==0) {
        ruHuoType = RuHuoTypeOfRuKu;
        JMSelectedExpressCompanyViewController * controllerVC = [[JMSelectedExpressCompanyViewController alloc]init];
        controllerVC.ruHuoType = ruHuoType;
        [self.navigationController pushViewController:controllerVC animated:YES];
        controllerVC.callBackBlock = ^(NSString * expressCompany){
            NSLog(@"%@",expressCompany);
            
        };
    }else if (indexPath.row==1){
        ruHuoType = RuHuoTypeOfRuHuoJia;
        JMSelectedExpressCompanyViewController * controllerVC = [[JMSelectedExpressCompanyViewController alloc]init];
        controllerVC.ruHuoType = ruHuoType;
        [self.navigationController pushViewController:controllerVC animated:YES];
        controllerVC.callBackBlock = ^(NSString * expressCompany){
            NSLog(@"%@",expressCompany);
            
        };
    }else if (indexPath.row==2){
        JMKongGuiViewController * kongGuiVC = [[JMKongGuiViewController alloc] init];
        [self.navigationController pushViewController:kongGuiVC animated:YES];
    }else{
        ///个人中心
        JMMineViewController * mineVC = [[JMMineViewController alloc] init];
        [self.navigationController pushViewController:mineVC animated:YES];
        return;
    }
    
}

-(void)requestHeadView
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@"day" forKey:@"frequency"];
    [dic setObject:[CommonUtils getCurrenttime] forKey:@"time"];
    [dic setObject:[UserAccountManager sharedInstance].user_id forKey:@"user_id"];
    [[HttpClient sharedInstance]getWorkStatusWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            workStatusModel =[[JMWorkStautsModel alloc] initWithDic:model.responseCommonDic];
            [self.collectionView reloadData];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
#pragma mark - 退出登录按钮
-(void)rightItemActionWithBtn:(UIButton *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil  message:@"确定退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UserAccountManager sharedInstance]exitLogin];
    }];
    
    //添加按钮
    [alert addAction:cancel];
    [alert addAction:ok];
    //以modal的方式来弹出
    [self presentViewController:alert animated:YES completion:^{ }];
    
    
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
