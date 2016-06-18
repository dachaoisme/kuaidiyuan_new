//
//  RegisterOneTableViewCell.h
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/17.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterOneTableViewCellDelegate <NSObject>

///获取身份证正面
- (void)inputContentWithTextField:(UITextField *)textField;

@end

@interface RegisterOneTableViewCell : UITableViewCell<UITextFieldDelegate>

///输入内容的textField
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;

@property (nonatomic,assign)id<RegisterOneTableViewCellDelegate>delegate;

@end
