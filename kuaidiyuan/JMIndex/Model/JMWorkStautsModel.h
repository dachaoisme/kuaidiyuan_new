//
//  JMWorkStautsModel.h
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMWorkStautsModel : NSObject
/*
 "ruku_cnt": 1,          //入库数
 "rugui_cnt": 0,         //入柜数
 "ruguojia_cnt": 0,      //入货架数
 "time_len": 0

 
 */

///入库数
@property(nonatomic,strong)NSString *workStautsOfRukuCnt;
///入柜数
@property(nonatomic,strong)NSString *workStautsOfRuguiCnt;
///如货架数
@property(nonatomic,strong)NSString *workStautsOfRuguojiaCnt;
///时间
@property(nonatomic,strong)NSString *workStautsOfTime_len;
-(id)initWithDic:(NSDictionary *)dic;
@end


