//
//  CourierHomePageTwoTableViewCell.h
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/17.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CourierHomePageTwoTableViewCellDelegate <NSObject>

- (void)confirmDelivery;

- (void)resendMessage;

- (void)call;

@end

@interface CourierHomePageTwoTableViewCell : UITableViewCell
///标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

///收件人手机号
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

///时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

///确认送达按钮
@property (weak, nonatomic) IBOutlet UIButton *confirmDelivery;

///重发短信
@property (weak, nonatomic) IBOutlet UIButton *resendMessageButton;

///代理
@property (nonatomic,assign)id<CourierHomePageTwoTableViewCellDelegate>delegate;

@end
