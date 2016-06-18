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
- (void)getIdCardFontWithBtn:(UIButton*)sender;

///获取身份证反面
- (void)getIdCardBackWithBtn:(UIButton*)sender;


@end

@interface RegisterTwoTableViewCell : UITableViewCell

@property (nonatomic,assign)id<RegisterTwoTableViewCellDelegate>delegate;

@end
