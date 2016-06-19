//
//  InSchoolTableViewCell.m
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/19.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "InSchoolTableViewCell.h"

@implementation InSchoolTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createContentView];
    }
    
    return self;
}

- (void)createContentView{
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 20)];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:timeLabel];
    
    self.timeLabel = timeLabel;
    
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(timeLabel.frame), CGRectGetMaxY(timeLabel.frame), SCREEN_WIDTH - 30, 20)];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
