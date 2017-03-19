//
//  JMKongGuiCollectionViewCell.h
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/19.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMKongGuiCollectionViewCell : UICollectionViewCell
///位置按钮
@property(nonatomic,strong)UIButton *locationBtn;
///空闲总数
@property(nonatomic,strong)UIButton *freeCountBtn;
///快递柜名称
@property(nonatomic,strong)UILabel *expressGuiNameLable;
///一类柜子
@property(nonatomic,strong)UILabel *yiLeiGuiNameLable;
///二类柜子
@property(nonatomic,strong)UILabel *erLeiLeiGuiGuiNameLable;
///三类柜子
@property(nonatomic,strong)UILabel *sanLeiGuiNameLable;
///左侧竖线
@property(nonatomic,strong)UIView * leftLineView;
///底部横线
@property(nonatomic,strong)UIView * bottomLineView;
@end
