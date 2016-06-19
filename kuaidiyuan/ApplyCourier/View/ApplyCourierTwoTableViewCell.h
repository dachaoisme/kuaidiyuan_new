//
//  ApplyCourierTwoTableViewCell.h
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/19.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyCourierTwoTableViewCell : UITableViewCell
///标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

///内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;



///不可修改按钮
@property (weak, nonatomic) IBOutlet UILabel *notChangeLabel;
@end
