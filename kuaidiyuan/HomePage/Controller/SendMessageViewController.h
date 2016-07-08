//
//  SendMessageViewController.h
//  kuaidiyuan
//
//  Created by 王园园 on 16/6/18.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"
#import "CourierModel.h"
@interface SendMessageViewController : BaseViewController

@property(nonatomic,strong)NSString  *courierSnsStr;
@property(nonatomic,assign)CourierSendSnsType courierSendSnsType;
@property(nonatomic,strong)NSMutableArray  *courierScanResultArr;
@end
