//
//  RegisterTwoTableViewCell.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/17.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "RegisterTwoTableViewCell.h"

@implementation RegisterTwoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createView];
    }
    
    return self;
}

- (void)createView{
    
    
    UILabel *aleartLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 20)];
    aleartLabel.text = @"上传身份证照片";
    aleartLabel.textColor = [UIColor lightGrayColor];
    aleartLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:aleartLabel];
    
    
    //设置身份证正面
    UIButton *positiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    positiveButton.frame = CGRectMake(15, CGRectGetMaxY(aleartLabel.frame)+10, 140, 92);
    [positiveButton setBackgroundImage:[UIImage imageNamed:@"kuaidiyuan_idcard_front_upload"] forState:UIControlStateNormal];
    
    [positiveButton addTarget:self action:@selector(frontAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:positiveButton];
    
    
    //设置身份证反面
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(CGRectGetMaxX(positiveButton.frame) + 10, CGRectGetMaxY(aleartLabel.frame)+10, 140, 92);
    [backButton setBackgroundImage:[UIImage imageNamed:@"kuaidiyuan_idcard_back_upload"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:backButton];

    
    
    
    
}

#pragma mark - 获取照片的正面
- (void)frontAction{
    
    if ([_delegate respondsToSelector:@selector(getIdCardFont)]) {
        [_delegate getIdCardFont];
    }
    
}

#pragma mark - 获取照片反面
- (void)backAction{
    
    if ([_delegate respondsToSelector:@selector(getIdCardBack)]) {
        [_delegate getIdCardBack];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
