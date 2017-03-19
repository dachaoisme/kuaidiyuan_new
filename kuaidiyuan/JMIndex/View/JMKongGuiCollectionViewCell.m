//
//  JMKongGuiCollectionViewCell.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/19.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMKongGuiCollectionViewCell.h"

@implementation JMKongGuiCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setContentView];
    }
    return self;
}
-(void)setContentView
{
    weakSelf(weakSelf);
    ///位置图片
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(9);
        make.right.equalTo(self.mas_right).offset(-5);
        make.width.equalTo(@14);
        make.height.equalTo(@(16));
    }];
    ///剩余空柜的总个数
    [self.freeCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationBtn.mas_bottom);
        make.width.height.equalTo(@(50));
        make.centerX.equalTo(weakSelf.contentView.mas_centerX);
    }];
    ///快递柜名称
    [self.expressGuiNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.freeCountBtn.mas_bottom).offset(6);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    ///一类快递柜
    [self.yiLeiGuiNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.expressGuiNameLable.mas_bottom).offset(6);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    ///二类快递柜
    [self.erLeiLeiGuiGuiNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.yiLeiGuiNameLable.mas_bottom).offset(6);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    ///三类快递柜
    [self.sanLeiGuiNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.erLeiLeiGuiGuiNameLable.mas_bottom).offset(6);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    ///竖线
    [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(@1);
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_bottom).offset(-1);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(weakSelf.mas_width);
        make.height.equalTo(@1);
    }];
}
///位置
-(UIButton *)locationBtn
{
    if (!_locationBtn) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationBtn setImage:[UIImage imageNamed:@"iconfont_icon"] forState:UIControlStateNormal];
        [self.contentView addSubview:_locationBtn];
    }
    return _locationBtn;
}
///剩余总个数
-(UIButton *)freeCountBtn
{
    if (!_freeCountBtn) {
        _freeCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _freeCountBtn.backgroundColor = [UIColor redColor];
        _freeCountBtn.layer.masksToBounds = YES;
        _freeCountBtn.layer.cornerRadius = 25;
        _freeCountBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_freeCountBtn];
    }
    return _freeCountBtn;
}
///快递柜名称label
-(UILabel *)expressGuiNameLable
{
    if (!_expressGuiNameLable) {
        _expressGuiNameLable = [[UILabel alloc] init];
        _expressGuiNameLable.textColor = LLColorHex(@"454545");
        _expressGuiNameLable.numberOfLines = 1;
        _expressGuiNameLable.textAlignment = NSTextAlignmentCenter;
        _expressGuiNameLable.font = JMSystemFont(15.0);
        _expressGuiNameLable.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_expressGuiNameLable];
    }
    return _expressGuiNameLable;
}

///一类快递柜
-(UILabel *)yiLeiGuiNameLable
{
    if (!_yiLeiGuiNameLable) {
        _yiLeiGuiNameLable = [[UILabel alloc] init];
        _yiLeiGuiNameLable.textColor = LLColorHex(@"454545");
        _yiLeiGuiNameLable.numberOfLines = 1;
        _yiLeiGuiNameLable.textAlignment = NSTextAlignmentCenter;
        _yiLeiGuiNameLable.font = JMSystemFont(11);
        _yiLeiGuiNameLable.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_yiLeiGuiNameLable];
    }
    return _yiLeiGuiNameLable;
}
///二类快递柜
-(UILabel *)erLeiLeiGuiGuiNameLable
{
    if (!_erLeiLeiGuiGuiNameLable) {
        _erLeiLeiGuiGuiNameLable = [[UILabel alloc] init];
        _erLeiLeiGuiGuiNameLable.textColor = LLColorHex(@"454545");
        _erLeiLeiGuiGuiNameLable.numberOfLines = 1;
        _erLeiLeiGuiGuiNameLable.textAlignment = NSTextAlignmentCenter;
        _erLeiLeiGuiGuiNameLable.font = JMSystemFont(11);
        _erLeiLeiGuiGuiNameLable.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_erLeiLeiGuiGuiNameLable];
    }
    return _erLeiLeiGuiGuiNameLable;
}
///三类快递柜
-(UILabel *)sanLeiGuiNameLable
{
    if (!_sanLeiGuiNameLable) {
        _sanLeiGuiNameLable = [[UILabel alloc] init];
        _sanLeiGuiNameLable.textColor = LLColorHex(@"454545");
        _sanLeiGuiNameLable.numberOfLines = 1;
        _sanLeiGuiNameLable.textAlignment = NSTextAlignmentCenter;
        _sanLeiGuiNameLable.font = JMSystemFont(11);
        _sanLeiGuiNameLable.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_sanLeiGuiNameLable];
    }
    return _sanLeiGuiNameLable;
}
-(UIView*)leftLineView
{
    if (!_leftLineView) {
        _leftLineView = [[UIView alloc]init];
        _leftLineView.backgroundColor = LLColorHex(@"e5e5e5");
        [self.contentView addSubview:_leftLineView];
    }
    return _leftLineView;
}
-(UIView*)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = LLColorHex(@"e5e5e5");
        [self.contentView addSubview:_bottomLineView];
    }
    return _bottomLineView;
}
@end
