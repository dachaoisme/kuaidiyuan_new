//
//  AppDelegate.h
//  kuaidiyuan
//
//  Created by lidachao on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

//极光推送
static NSString *appKey = @"a07cc19303cef9804a468983";
static NSString *channel = @"Publish channel";
static BOOL isProduction = YES;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
-(void)setRootViewController;
@end

