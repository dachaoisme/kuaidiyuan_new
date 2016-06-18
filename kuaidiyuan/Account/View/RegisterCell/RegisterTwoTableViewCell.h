//
//  RegisterTwoTableViewCell.h
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/17.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterTwoTableViewCellDelegate <NSObject>

///获取身份证正面
- (void)getIdCardFont;

///获取身份证反面
- (void)getIdCardBack;


@end

@interface RegisterTwoTableViewCell : UITableViewCell

@property (nonatomic,assign)id<RegisterTwoTableViewCellDelegate>delegate;

@end
