//
//  JMIndexHeadView.h
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/6.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMIndexHeadView : UIView
///今日入件
@property(nonatomic,strong)UILabel *todayIncomeStorageCountLabel;
///今日入货架
@property(nonatomic,strong)UILabel *todayIncomeRackCountLabel;
///今日如柜子
@property(nonatomic,strong)UILabel *todayIncomeCupboardCountLabel;

@end
