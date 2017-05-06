//
//  JMKongGuiViewController.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/19.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMKongGuiViewController.h"
#import "JMExpressGuiUseDetailModel.h"
#import "JMKongGuiCollectionViewCell.h"
@interface JMKongGuiViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSString * collegeId;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation JMKongGuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title  =@"空柜状态";
    self.dataArray = [NSMutableArray array];
    [self createLeftBackNavBtn];
    [self setupContentView];
    [self requestData];
    
}
-(void)requestData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserAccountManager sharedInstance].colledge_id forKey:@"collegeid"];
    [[HttpClient sharedInstance]getKongGuiStatusWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSDictionary * tempDic = (NSDictionary *)model.responseCommonDic;
        if (tempDic.count == 0) {
            
            [CommonUtils showToastWithStr:@"暂无内容哦"];
            return ;
        }
        NSArray * keyArray = [tempDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
        for (NSString * key in keyArray) {
            JMExpressGuiUseBigModel * bigModel = [[JMExpressGuiUseBigModel alloc]initWithDic:nil];
            NSDictionary *kongGuiDetailDic = [tempDic objectForKey:key];
            bigModel.ExpressGuiLocation =[kongGuiDetailDic objectForKey:@"name"];
            bigModel.ExpressGuiTypeName = key;
            NSArray * smallKeyArray = [kongGuiDetailDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
            for (NSString * smallKey in smallKeyArray) {
                if ([[kongGuiDetailDic objectForKey:smallKey] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary * smallDic = [kongGuiDetailDic objectForKey:smallKey];
                    JMExpressGuiUseDetailModel * kongGuiModel   = [[JMExpressGuiUseDetailModel alloc]initWithDic:smallDic];
                    [bigModel.ExpressGuiTypeArray addObject:kongGuiModel];
                }
                
            }
            [self.dataArray addObject:bigModel];
        }
        [self.collectionView reloadData];
    } withFaileBlock:^(NSError *error) {
        
    }];
    
    
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
    layout.itemSize = CGSizeMake((self.view.bounds.size.width - horizontalSpaceing * 3.1) / 2, 160 * VMScaleOfCurrentDeviceAndModelDeviceWidth - horizontalSpaceing);
    layout.sectionInset = UIEdgeInsetsMake(verticalSpaceing * VMScaleOfCurrentDeviceAndModelDeviceWidth, horizontalSpaceing, verticalSpaceing, horizontalSpaceing);
    CGRect rect;
    rect = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.view.frame));
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    [self.collectionView registerClass:[JMKongGuiCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JMKongGuiCollectionViewCell class])];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JMKongGuiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JMKongGuiCollectionViewCell class]) forIndexPath:indexPath];
    JMExpressGuiUseBigModel *item = [self.dataArray objectAtIndex:indexPath.row];
    [cell.locationBtn addTarget:self action:@selector(locationMessageWithButton:) forControlEvents:UIControlEventAllTouchEvents];
    cell.locationBtn.tag = indexPath.row;
    cell.expressGuiNameLable.text = item.ExpressGuiTypeName;
    int allFreeCount = 0;
    int allCount = 0;
    for (int i = 0; i<item.ExpressGuiTypeArray.count; i++) {
        
        JMExpressGuiUseDetailModel * model = [item.ExpressGuiTypeArray objectAtIndex:i];
        if (i==0) {
            cell.yiLeiGuiNameLable.text = [NSString stringWithFormat:@"%@柜位%@个，空闲%@个",model.ExpressGuiTypeName,model.ExpressGuiTotalCount,model.ExpressGuiFreeCount];
        }else if (i==1){
            cell.erLeiLeiGuiGuiNameLable.text = [NSString stringWithFormat:@"%@柜位%@个，空闲%@个",model.ExpressGuiTypeName,model.ExpressGuiTotalCount,model.ExpressGuiFreeCount];
        }else{
            cell.sanLeiGuiNameLable.text = [NSString stringWithFormat:@"%@柜位%@个，空闲%@个",model.ExpressGuiTypeName,model.ExpressGuiTotalCount,model.ExpressGuiFreeCount];
        }
        allFreeCount = allFreeCount+[model.ExpressGuiFreeCount intValue];
        allCount = allCount+[model.ExpressGuiTotalCount intValue];
    }
    [cell.freeCountBtn setTitle:[NSString stringWithFormat:@"总空闲%d",allFreeCount] forState:UIControlStateNormal];
    [cell.freeCountBtn setBackgroundColor:[CommonUtils colorWithHex:[self colorWithScale:allFreeCount/allCount]]];
    
    
    return cell;
}
-(NSString *)colorWithScale:(int)scale
{
    if (scale==0) {
        return @"fb8c6e";
    }else if (0<scale<=0.25){
        return @"f4c545";
    }else if (0.25<scale<0.5){
        return @"8d9ff3";
    }else if (0.5<scale<0.75){
        return @"64ccfa";
    }else{
        return @"3ed0a7";
    }
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)locationMessageWithButton:(UIButton *)sender
{
    JMExpressGuiUseBigModel *item = [self.dataArray objectAtIndex:sender.tag];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil  message:item.ExpressGuiLocation preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    //添加按钮
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
