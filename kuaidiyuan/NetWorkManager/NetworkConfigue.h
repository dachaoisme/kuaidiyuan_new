//
//  NetworkConfigue.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#ifndef NetworkConfigue_h
#define NetworkConfigue_h

#pragma mark - 服务器地址相关
///api的地址
#define baseApiUrl        @"http://123.56.27.124/api/web/"
///后台管理系统图片的地址
#define baseBackgroundUrlType1 @"http://123.56.27.124"
#define baseBackgroundUrlType2 @"http://123.56.27.124/backend/web/"


#pragma mark - 用户相关
///发送验证码
#define METHOD_OF_SEND_MESSAGE           @"v1/user/sendmessage?"
///登录
#define METHOD_OF_LOGIN                  @"v1/courier/signin?"
///注册
#define METHOD_OF_REGISTER               @"v1/courier/reg/?"
///用户头像上传
#define METHOD_OF_UPLOAD                 @"v1/user/upload/"
///上传身份证等多张图片
#define METHOD_OF_IMAGES_UPLOAD          @"v1/fleamarket/imageupload/"
///完善资料
#define METHOD_OF_INFO_PERFECT           @"v1/courier/updateuserinfo/"
///根据关键字查询学校
#define METHOD_OF_COLLEGE_SEARCH         @"v1/college/search?"



#pragma mark - 送快递相关
///送快递记录
#define METHOD_SEND_EXPRESS_HISTORY              @"v1/courier/expressrecord?"
///设置快递员上下班接口
#define METHOD_CONFIGURE_WORK                    @"v1/courier/working?"
///发快递取件消息接口
#define METHOD_CONFIGURE_SEND_MESSAGE            @"v1/courier/messages?"
///短信模板列表接口
#define METHOD_CONFIGURE_TEMPLATES_LIST          @"v1/templates/list?"
///添加短信模板接口
#define METHOD_CONFIGURE_TEMPLATES_CREATE        @"v1/templates/create?"
///修改短信模板接口
#define METHOD_CONFIGURE_TEMPLATES_UPDATE        @"v1/templates/update?"
///删除短信模板接口
#define METHOD_CONFIGURE_TEMPLATES_DELETE        @"v1/templates/delete?"

#endif /* NetworkConfigue_h */
