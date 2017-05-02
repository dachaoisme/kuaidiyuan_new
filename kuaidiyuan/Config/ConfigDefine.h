//
//  ConfigDefine.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#ifndef ConfigDefine_h
#define ConfigDefine_h


#pragma mark - 全局参数配置
//====sdks 微信
#define MF_WeChat_AppKey @""
#define MF_WeChat_AppID  @"wx79e27896493774c9"
#define MF_WeChat_Secret @"aa8c8f83b88ffa2dd8cb15a927441307"
//高德
//个人
//#define k_map_AppKey @"bfcdde8157e2605ec119e32d511bcf3c"
//企业
#define k_map_AppKey @"32863171e0292a6e3b59a88c41dab43a"

// 友盟
#define k_um_AppKey @"55c01cc967e58e4304006420"


#define weakSelf(wSelf)  __weak __typeof(&*self)wSelf = self;

// 判断iPhone4/4s
#define IS_IPHONE_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone5
#define IS_IPHONE_5 ( fabs( ( double )[[ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
//判断iphone6
#define IS_IPHONE_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone6+
#define IS_IPHONE_6_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//判断系统
#define iOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define iOS9 [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0


// 调试状态, 打开Log功能
#ifdef DEBUG
#define MFLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭Log功能
#define MFLog(...)
#endif

//判断是否为真机
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

//非空判断 宏
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

#ifdef DEBUG
#   define XHNLog(fmt, ...) NSLog((@"%@ [Line %d] " fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, ##__VA_ARGS__);
#   define NSLog(...) NSLog(__VA_ARGS__)
#else
#   define XHNLog(...)
#   define NSLog(...) {}
#endif

//各个高度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define STATUSBAR_HEIGHT 20

#define NAVIGATIONBAR_HEIGHT 44

#define NAV_TOP_HEIGHT 64

#define TABBAR_HEIGHT 49

#define TABBAR_ICON_HEIGHT 30

#define CONTENT_HEIGHT (SCREEN_HEIGHT-NAV_TOP_HEIGHT-TABBAR_HEIGHT)

#define CONTENT_HEIGHT_Super (SCREEN_HEIGHT-TABBAR_HEIGHT)

#define CONTENT_HEIGHT_2 (SCREEN_HEIGHT-NAV_TOP_HEIGHT)

#define LLColorHex(hex) [CommonUtils colorWithHex:hex]
#define LLColorLine     LLColorHex(@"d1d1d1")// 目前使用的线的颜色（中间的分割线）
#define F_PX_TO_PT(px) px/3.0
#define PX_TO_PT(px) px*SCREEN_WIDTH/1242.0
#define LLColorBg       LLColorHex(@"f3f3f3")// 页面背景的颜色



///NavigationBar主题颜色
#define NAVIGATIONBAR_THEMECOLOR [UIColor blackColor]
#define NAVIGATIONBAR_TITLECOLOR [UIColor whiteColor]


#pragma mark - 集梦盒子二期
#define HiddenTarget(targetView) targetView.hidden = YES;
#define VMScaleOfCurrentDeviceAndModelDeviceWidth (SCREEN_WIDTH < SCREEN_HEIGHT ? (SCREEN_WIDTH / 375) : (SCREEN_HEIGHT / 375))
#define JMSystemFont(fontSize) [UIFont systemFontOfSize:(fontSize * VMScaleOfCurrentDeviceAndModelDeviceWidth)]
#define JMUIFont(fontSize) JMSystemFont(fontSize))


#define TitleNormalBlackColor @"5e5e5e"
#define TitleNormalRedColor @"ff566d"
#define TitleNormalLightGrayColor @"95969c"


///普通黑色 一级标题
#define NORMAL_TITLE_BLACK_COLOR @"3f4446"
///普通黑色二级标题
#define NORMAL_SUBTITLE_BLACK_COLOR @"999999"
///蓝色线条选中颜色
#define NORMAL_HEIGHTLIGHT_COLOR @"00c05c"
///页面背景颜色
#define NORMAL_BACKGROUND_COLOR @"f5f5f5"
#endif /* ConfigDefine_h */
