//
//  IndexModel.m
//  kuaidiyuan
//
//  Created by lidachao on 16/6/11.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "IndexModel.h"

@implementation IndexModel
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        
    }
    
    return self;
    
}

@end

@implementation ExpressInfoModel


-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.expressId         = [dic stringForKey:@"id"];
        self.expressType       = [dic stringForKey:@"express_type"];
        self.expressNum        = [dic stringForKey:@"express_no"];
        self.expressStrtus     = [dic stringForKey:@"status"];
        self.expressCreateTime = [dic stringForKey:@"create_at"];
        
    }
    
    return self;
    
}
@end

@implementation ExpressMessageModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.expressMessageId             = [dic stringForKey:@"id"];
        self.expressMessageTitle          = [dic stringForKey:@"title"];
        self.expressMessageMsg            = [dic stringForKey:@"msg"];
        self.expressMessageCreateTime     = [dic stringForKey:@"create_at"];
        
    }
    return self;
    
}
@end

@implementation MessageTemplateModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.messageTemplateId              = [dic stringForKey:@"id"];
        self.messageTemplateUserId          = [dic stringForKey:@"user_id"];
        self.messageTemplateTemplate        = [dic stringForKey:@"template"];
        self.messageTemplateCreateTime      = [dic stringForKey:@"create_at"];
        
    }
    return self;    
}
@end
