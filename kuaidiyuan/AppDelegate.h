//
//  AppDelegate.h
//  kuaidiyuan
//
//  Created by lidachao on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

//极光推送
static NSString *appKey = @"60a6f51d360a7060c47408b6";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
-(void)setRootViewController;
@end

