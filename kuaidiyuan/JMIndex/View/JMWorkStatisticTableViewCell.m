//
//  JMWorkStatisticTableViewCell.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/4/9.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMWorkStatisticTableViewCell.h"

@implementation JMWorkStatisticTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self timeTitleLabel];
        [self contentTitleLabel];
        [self clockTimeLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    weakSelf(weakSelf);
   
    ///时间
    [self.timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(16);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top).offset(12);
    }];
 
    ///内容
    [self.contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.timeTitleLabel.mas_left);
        make.right.equalTo(weakSelf.timeTitleLabel.mas_right);
        make.top.equalTo(weakSelf.timeTitleLabel.mas_bottom).offset(7 * VMScaleOfCurrentDeviceAndModelDeviceWidth);
    }];
    
    ///打卡时间
    [self.clockTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentTitleLabel.mas_left);
        make.right.equalTo(weakSelf.contentTitleLabel.mas_right);
        make.top.equalTo(weakSelf.contentTitleLabel.mas_bottom).offset(3);
    }];
}


#pragma mark - lazy

///视频标题
- (UILabel *)timeTitleLabel
{
    if (_timeTitleLabel == nil) {
        _timeTitleLabel = [[UILabel alloc] init];
        _timeTitleLabel.font = JMSystemFont(13);
        _timeTitleLabel.textColor = [CommonUtils colorWithHex:TitleNormalBlackColor];
        _timeTitleLabel.numberOfLines = 1;
        _timeTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_timeTitleLabel];
    }
    return _timeTitleLabel;
}

///视频标题
- (UILabel *)contentTitleLabel
{
    if (_contentTitleLabel == nil) {
        _contentTitleLabel = [[UILabel alloc] init];
        _contentTitleLabel.font = JMSystemFont(13);
        _contentTitleLabel.textColor = [CommonUtils colorWithHex:TitleNormalBlackColor];
        _contentTitleLabel.numberOfLines = 1;
        _contentTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_contentTitleLabel];
    }
    return _contentTitleLabel;
}

///视频标题
- (UILabel *)clockTimeLabel
{
    if (_clockTimeLabel == nil) {
        _clockTimeLabel = [[UILabel alloc] init];
        _clockTimeLabel.font = JMSystemFont(13);
        _clockTimeLabel.textColor = [CommonUtils colorWithHex:TitleNormalBlackColor];
        _clockTimeLabel.numberOfLines = 1;
        _clockTimeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_clockTimeLabel];
    }
    return _clockTimeLabel;
}

@end
