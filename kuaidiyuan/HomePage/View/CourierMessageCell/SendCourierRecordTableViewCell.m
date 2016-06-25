//
//  SendCourierRecordTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SendCourierRecordTableViewCell.h"

@implementation SendCourierRecordTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    
    _cancleButton.layer.cornerRadius = 6;
    _cancleButton.layer.masksToBounds = YES;
    _cancleButton.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [_cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}
/*
 ///头像
 @property (weak, nonatomic) IBOutlet UIImageView *headImageView;
 ///姓名
 @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
 ///详情
 @property (weak, nonatomic) IBOutlet UILabel *contentLabel;
 ///时间
 @property (weak, nonatomic) IBOutlet UILabel *timeLabel;
 ///取件地址
 @property (weak, nonatomic) IBOutlet UILabel *takeAdress;
 ///取件时间
 @property (weak, nonatomic) IBOutlet UILabel *takeTime;
 ///取件状态
 @property (weak, nonatomic) IBOutlet UILabel *takeStatues;
 
 ///取消取件按钮显示
 @property (weak, nonatomic) IBOutlet UIButton *cancleButton;
 */
- (void)bindModel:(CourierIncompleteMessageModel *)model{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.courierMessageIcon] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
    self.nameLabel.text = model.courierMessageNickName;
    self.contentLabel.text = model.courierMessageIdFetchTelephone;
    self.timeLabel.text = model.courierMessageCreateTime;
    self.takeTime.text=model.courierMessageIdFetchTime;;
    self.takeAdress.text = model.courierMessageAdress;
    if (model.courierMessageStatus == courierMessageCancelTakeStatus) {
        //取消发件
        self.takeStatues.text = @"已取消";
        self.cancleButton.hidden = YES;
        self.takeStatues.textColor = [CommonUtils colorWithHex:@"808184"];
    }else if (model.courierMessageStatus == courierMessageWaitingTakeStatus){
        ///等待取件
        self.takeStatues.text = @"等待取件";
        self.cancleButton.hidden = NO;
        self.takeStatues.textColor = [CommonUtils colorWithHex:@"00beaf"];
    }else{
        //已经取件
        self.takeStatues.text = [NSString stringWithFormat:@"已于%@ 取件",model.courierMessageIdFetchTime];
        self.cancleButton.hidden = YES;
        self.takeStatues.textColor = [CommonUtils colorWithHex:@"808184"];
    }
}

//- (void)bindModel:(ExpressCenterExpressInfoModel *)model{
//    
//    self.nameLabel.text = model.expressCenterExpressInfoExpressPeopleName;
//    
//    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.expressCenterExpressInfoExpressPeopleImg] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
//    
//    self.timeLabel.text = model.expressCenterExpressInfoCreateTime;
//    
//    self.takeAdress.text = model.expressCenterExpressInfoAdress;
//    
//    self.takeTime.text = model.expressCenterExpressInfoFetchTime;
//    
//    
//    if ([model.expressCenterExpressInfoStatus intValue] == -1) {
//        
//        //取消取件
//        self.takeStatues.text = @"已取消取件";
//        self.cancleButton.hidden = YES;
//        
//    }else if ([model.expressCenterExpressInfoStatus intValue] == 0){
//        
//        //等待取件
//        self.takeStatues.text = @"等待取件";
//        
//        
//    }else if([model.expressCenterExpressInfoStatus intValue] == 1){
//        
//        //已取件
//        
//        self.takeStatues.text = [NSString stringWithFormat:@"已于%@取件",model.expressCenterExpressInfoDetailCreateTime];
//        self.cancleButton.hidden = YES;
//        
//    }
//    
//}

#pragma mark - 拨打电话
- (IBAction)callButtonAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(callWithIndex:)]) {
        [_delegate callWithIndex:self.tag];
    }
}

#pragma mark - 取消取件按钮
- (IBAction)cancleButtonAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(cancleTakeThingWithIndex:)]) {
        [_delegate cancleTakeThingWithIndex:self.tag];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
