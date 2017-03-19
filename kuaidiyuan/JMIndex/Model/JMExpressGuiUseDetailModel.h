//
//  JMExpressGuiUseDetailModel.h
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/19.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMExpressGuiUseDetailModel : NSObject
/*
 {
 "stat": 1,
 "msg": "succ",
 "data": {
 "JLJCXY001": {
 "0": {
 "total_count": 42,
 "door_type": "中格",
 "free_count": 39
 },
 "1": {
 "total_count": 14,
 "door_type": "大格",
 "free_count": 13
 },
 "2": {
 "total_count": 92,
 "door_type": "小格",
 "free_count": 76
 },
 "name": "攀登楼旁A区"
 },
 
 }
 }
 }
 
 */

///空柜总数
@property(nonatomic,strong)NSString *ExpressGuiTotalCount;
///控规类型
@property(nonatomic,strong)NSString *ExpressGuiTypeName;
///空柜空闲个数
@property(nonatomic,strong)NSString *ExpressGuiFreeCount;
-(id)initWithDic:(NSDictionary *)dic;
@end

@interface JMExpressGuiUseBigModel : NSObject


///空柜总数
@property(nonatomic,strong)NSString *ExpressGuiTotalFreeCount;
///快递柜名称
@property(nonatomic,strong)NSString *ExpressGuiTypeName;
///快递柜位置
@property(nonatomic,strong)NSString *ExpressGuiLocation;
///柜子类型数组
@property(nonatomic,strong)NSMutableArray *ExpressGuiTypeArray;

-(id)initWithDic:(NSDictionary *)dic;
@end
