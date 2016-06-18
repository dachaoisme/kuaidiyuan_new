//
//  RegisterOneTableViewCell.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/17.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "RegisterOneTableViewCell.h"

@implementation RegisterOneTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(inputContentWithTextField:)]) {
        [self.delegate inputContentWithTextField:textField];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
