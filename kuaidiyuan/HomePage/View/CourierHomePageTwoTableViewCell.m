//
//  CourierHomePageTwoTableViewCell.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/17.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "CourierHomePageTwoTableViewCell.h"

@implementation CourierHomePageTwoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _confirmDelivery.layer.cornerRadius = 6;
    _confirmDelivery.layer.masksToBounds = YES;
    _confirmDelivery.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [_confirmDelivery setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    _resendMessageButton.layer.cornerRadius = 6;
    _resendMessageButton.layer.borderWidth = 1;
    _resendMessageButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _resendMessageButton.layer.masksToBounds = YES;
    _resendMessageButton.backgroundColor = [UIColor whiteColor];
    [_resendMessageButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    
}

#pragma mark - 确认送达按钮
- (IBAction)makeSureDelayAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(confirmDeliveryWithIndex:)]) {
        [_delegate confirmDeliveryWithIndex:self.tag];
    }
}


#pragma mark - 从发短信按钮
- (IBAction)resendMessageAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(resendMessageWithIndex:)]) {
        [_delegate resendMessageWithIndex:self.tag];
    }
}

#pragma mark - 打电话
- (IBAction)callAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(callWithIndex:)]) {
        [_delegate callWithIndex:self.tag];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
