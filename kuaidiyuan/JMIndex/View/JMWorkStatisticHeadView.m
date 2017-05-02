//
//  JMWorkStatisticHeadView.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/4/9.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMWorkStatisticHeadView.h"

@implementation JMWorkStatisticHeadView


-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setContentView];
    }
    return self;
}

-(void)setContentView
{
    float titleWidth = 62;
    float titleHeight = 25;
    float horizontalSpace = (SCREEN_WIDTH-titleWidth*2)/3;
    float verticalTopSpace =6;
    float verticalBottomSpace = (CGRectGetHeight(self.frame) -horizontalSpace*2)/3;
    ///今日入库
    UILabel *todayIncomeStorageTitleLabel = [self label];
    todayIncomeStorageTitleLabel.font = JMSystemFont(12.0f);
    todayIncomeStorageTitleLabel.text = @"今日入库";
    UILabel *todayIncomeStorageCountLabel = [self label];
    todayIncomeStorageCountLabel.font = JMSystemFont(20.0);
    self.todayIncomeStorageCountLabel = todayIncomeStorageCountLabel;
    ///今日入货架
    UILabel *todayIncomeRackTitleLabel = [self label];
    todayIncomeRackTitleLabel.font = JMSystemFont(12.0f);
    todayIncomeRackTitleLabel.text = @"快递入货架";
    UILabel *todayIncomeRackCountLabel = [self label];
    todayIncomeRackCountLabel.font = JMSystemFont(20.0);
    self.todayIncomeRackCountLabel = todayIncomeRackCountLabel;
    ///今日如柜子
    UILabel *todayIncomeCupboardTitleLabel = [self label];
    todayIncomeCupboardTitleLabel.font = JMSystemFont(12.0f);
    todayIncomeCupboardTitleLabel.text = @"今日入柜";
    UILabel *todayIncomeCupboardCountLabel = [self label];
    todayIncomeCupboardCountLabel.font = JMSystemFont(20.0);
    self.todayIncomeCupboardCountLabel = todayIncomeCupboardCountLabel;
    
    ///打卡时间
    UILabel *todayClockTimeTitleLabel = [self label];
    todayClockTimeTitleLabel.font = JMSystemFont(12.0f);
    todayClockTimeTitleLabel.text = @"工作时长";
    UILabel *todayClockTimeLabel = [self label];
    todayClockTimeLabel.font = JMSystemFont(20.0);
    self.todayClockTimeLabel = todayClockTimeLabel;
    
    ///今日入件
    [todayIncomeStorageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(verticalTopSpace);
        make.left.equalTo(self.mas_left).offset(horizontalSpace);
        make.width.equalTo(@(titleWidth));
        make.height.equalTo(@(titleHeight));
    }];
    [todayIncomeStorageCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(todayIncomeStorageTitleLabel.mas_bottom);
        make.left.equalTo(todayIncomeStorageTitleLabel.mas_left);
        make.width.equalTo(todayIncomeStorageTitleLabel.mas_width);
        make.height.equalTo(todayIncomeStorageTitleLabel.mas_height);
    }];
    
    ///今日入货架
    [todayIncomeRackTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(verticalTopSpace);
        make.left.equalTo(todayIncomeStorageTitleLabel.mas_right).offset(horizontalSpace);
        make.width.equalTo(@(titleWidth));
        make.height.equalTo(@(titleHeight));
    }];
    [todayIncomeRackCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(todayIncomeRackTitleLabel.mas_bottom);
        make.left.equalTo(todayIncomeRackTitleLabel.mas_left);
        make.width.equalTo(todayIncomeRackTitleLabel.mas_width);
        make.height.equalTo(todayIncomeRackTitleLabel.mas_height);
    }];
    
    //////今日如柜子
    [todayIncomeCupboardTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(todayIncomeRackCountLabel.mas_bottom).offset(verticalTopSpace);
        make.left.equalTo(self.mas_left).offset(horizontalSpace);
        make.width.equalTo(@(titleWidth));
        make.height.equalTo(@(titleHeight));
    }];
    [todayIncomeCupboardCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(todayIncomeCupboardTitleLabel.mas_bottom);
        make.left.equalTo(todayIncomeCupboardTitleLabel.mas_left);
        make.width.equalTo(todayIncomeCupboardTitleLabel.mas_width);
        make.height.equalTo(todayIncomeCupboardTitleLabel.mas_height);
    }];
    
    //////打卡时间
    [todayClockTimeTitleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(todayIncomeCupboardTitleLabel.mas_top);
        make.left.equalTo(todayIncomeCupboardTitleLabel.mas_right).offset(horizontalSpace);
        make.width.equalTo(@(titleWidth));
        make.height.equalTo(@(titleHeight));
    }];
    [todayClockTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(todayClockTimeTitleLabel.mas_bottom);
        make.left.equalTo(todayClockTimeTitleLabel.mas_left);
        make.width.equalTo(todayClockTimeTitleLabel.mas_width);
        make.height.equalTo(todayClockTimeTitleLabel.mas_height);
    }];
    
}

- (UILabel *)label
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [CommonUtils colorWithHex:NORMAL_TITLE_BLACK_COLOR];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    [self addSubview:label];
    
    return label;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
