//
//  JMSelectedExpressCompanyViewController.h
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "BaseViewController.h"

@interface JMSelectedExpressCompanyViewController : BaseViewController

///选择快递公司的block
@property(nonatomic,copy)SelectedCourierCompanyBlock callBackBlock;
@property(nonatomic,assign)RuHuoType ruHuoType;
@end
