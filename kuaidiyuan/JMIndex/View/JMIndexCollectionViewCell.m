//
//  JMIndexCollectionViewCell.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/6.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMIndexCollectionViewCell.h"

@implementation JMIndexCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self setContentView];
    }
    return self;
}
-(void)setContentView
{
//    float height =170*VMScaleOfCurrentDeviceAndModelDeviceWidth;
//    float width =SCREEN_WIDTH/2;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(28);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        //make.width.equalTo(@(80*VMScaleOfCurrentDeviceAndModelDeviceWidth));
        make.height.equalTo(@(30));
    }];
    
    [self.titelLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(19);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        //make.width.equalTo(@(80*VMScaleOfCurrentDeviceAndModelDeviceWidth));
        make.height.equalTo(@(30));
    }];
}
///视频图片
- (UIImageView *)icon
{
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_icon];
    }
    return _icon;
}
- (UILabel *)titelLable
{
    if (!_titelLable) {
        _titelLable = [[UILabel alloc] init];
        _titelLable.textColor = [UIColor whiteColor];
        _titelLable.numberOfLines = 1;
        _titelLable.textAlignment = NSTextAlignmentCenter;
        _titelLable.font = JMSystemFont(15.0);
        _titelLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_titelLable];
    }
    return _titelLable;
}
@end
