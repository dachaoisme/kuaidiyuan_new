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
@interface JMIndexViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation JMIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  =@"集梦盒子快递员";
    
    [self setupContentView];
    
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
        headView.todayIncomeStorageCountLabel.text = @"232件";
        headView.todayIncomeRackCountLabel.text = @"108件";
        headView.todayIncomeCupboardCountLabel.text = @"20件";
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
