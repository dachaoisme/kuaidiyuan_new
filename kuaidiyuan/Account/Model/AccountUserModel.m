//
//  AccountUserModel.m
//  kuaidiyuan
//
//  Created by lidachao on 16/6/11.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AccountUserModel.h"

@implementation AccountUserModel

@end



@implementation ApplyCourierModel
/*
 @property(nonatomic,strong)NSString * courierRealName;
 @property(nonatomic,strong)NSString * courierIdentityCard;
 @property(nonatomic,strong)NSString * courierCollege;
 @property(nonatomic,strong)NSString * courierClass;
 @property(nonatomic,strong)NSString * courierMajor;
 @property(nonatomic,strong)NSString * courierStudentID;
 */

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.courierRealName            = @"";
        self.courierIdentityCard        = @"";
        self.courierCollege             = @"";
        self.courierClass               = @"";
        self.courierMajor               = @"";
        self.courierStudentID           = @"";
        
    }
    
    return self;
}



@end
