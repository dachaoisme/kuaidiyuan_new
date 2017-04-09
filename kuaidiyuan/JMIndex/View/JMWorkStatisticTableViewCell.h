//
//  JMWorkStatisticTableViewCell.h
//  kuaidiyuan
//
//  Created by dachao li on 2017/4/9.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMWorkStatisticTableViewCell : UITableViewCell
///时间
@property(nonatomic,strong)UILabel *timeTitleLabel;
///入库、入货价、入柜
@property(nonatomic,strong)UILabel *contentTitleLabel;
///打卡时间
@property(nonatomic,strong)UILabel *clockTimeLabel;
@end
