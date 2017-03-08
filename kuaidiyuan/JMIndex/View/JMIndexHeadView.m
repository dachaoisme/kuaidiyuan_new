//
//  JMIndexHeadView.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/6.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMIndexHeadView.h"
#import "CommonUtils.h"
@implementation JMIndexHeadView


-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [CommonUtils colorWithHex:@"3ed0a7"];
        [self setContentView];
    }
    return self;
}

-(void)setContentView
{
    float titleWidth = 62*VMScaleOfCurrentDeviceAndModelDeviceWidth;
    float titleHeight = 25*VMScaleOfCurrentDeviceAndModelDeviceWidth;
    float horizontalSpace = (SCREEN_WIDTH-titleWidth*3)/4*VMScaleOfCurrentDeviceAndModelDeviceWidth;
    float verticalTopSpace = (CGRectGetHeight(self.frame) -horizontalSpace*2)/3*VMScaleOfCurrentDeviceAndModelDeviceWidth;
    float verticalBottomSpace = (CGRectGetHeight(self.frame) -horizontalSpace*2)/3*2*VMScaleOfCurrentDeviceAndModelDeviceWidth;
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
        make.top.equalTo(self.mas_top).offset(verticalTopSpace);
        make.left.equalTo(todayIncomeRackTitleLabel.mas_right).offset(horizontalSpace);
        make.width.equalTo(@(titleWidth));
        make.height.equalTo(@(titleHeight));
    }];
    [todayIncomeCupboardCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(todayIncomeCupboardTitleLabel.mas_bottom);
        make.left.equalTo(todayIncomeCupboardTitleLabel.mas_left);
        make.width.equalTo(todayIncomeCupboardTitleLabel.mas_width);
        make.height.equalTo(todayIncomeCupboardTitleLabel.mas_height);
    }];
    
    UILabel * dateLabel = [self label];
    dateLabel.text = [CommonUtils getCurrenttime];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_bottom).offset(-40*VMScaleOfCurrentDeviceAndModelDeviceWidth);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(21*VMScaleOfCurrentDeviceAndModelDeviceWidth));
    }];
}

- (UILabel *)label
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
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
