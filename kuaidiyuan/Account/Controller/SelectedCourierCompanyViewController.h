//
//  SelectedCourierCompanyViewController.h
//  kuaidiyuan
//
//  Created by lidachao on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectedCourierCompanyViewController : BaseViewController

///选择快递公司的block
@property(nonatomic,copy)SelectedCourierCompanyBlock callBackBlock;
@end
