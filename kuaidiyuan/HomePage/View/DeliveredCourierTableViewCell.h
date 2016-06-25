//
//  DeliveredCourierTableViewCell.h
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeliveredCourierTableViewCellDelegate <NSObject>

- (void)callWithIndex:(NSInteger)index;

@end

@interface DeliveredCourierTableViewCell : UITableViewCell

///订单号
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

///收件人手机号
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

///收件日期
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

///送达按钮
@property (weak, nonatomic) IBOutlet UIButton *deliveryButton;


///代理
@property (nonatomic,assign)id<DeliveredCourierTableViewCellDelegate>delegate;


@end
