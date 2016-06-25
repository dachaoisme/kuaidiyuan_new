//
//  DeliveredCourierTableViewCell.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "DeliveredCourierTableViewCell.h"

@implementation DeliveredCourierTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _deliveryButton.layer.cornerRadius = 6;
    _deliveryButton.layer.masksToBounds = YES;
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
