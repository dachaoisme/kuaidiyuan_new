//
//  ApplyCourierTableViewCell.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/15.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "ApplyCourierTableViewCell.h"

@implementation ApplyCourierTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.contentTextField.returnKeyType = UIReturnKeyDone;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
