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
///api的地址 集梦盒子一期 学院派二期
#define baseApiUrl @"http://114.215.111.210:999/frontend/web/index.php?r="
///#define baseApiUrl        @"http://114.215.111.210/api/web/"
///后台管理系统图片的地址
#define baseBackgroundUrlType1 @"http://123.56.27.124"
#define baseBackgroundUrlType2 @"http://123.56.27.124/backend/web/"


#pragma mark - 用户相关

///发送验证码
#define METHOD_OF_SEND_MESSAGE           @"v1/courier/sendsnsbytel?"
///校验验证码和手机号
#define CHECK_PHONE_CODE                 @"v1/courier/validatetel?"


///个人中心：个人主页 使用的学院派的接口
#define METHOD_MINE_HOME_PAGE            @"v1/user/userinfo?"

///修改手机号绑定
#define CHANGE_BIND_PHONE                @"v1/courier/updatetel?"
///登录
#define METHOD_OF_LOGIN                  @"v1/courier/signin?"
///注册
#define METHOD_OF_REGISTER               @"v1/courier/reg/?"
///用户头像上传
#define METHOD_OF_UPLOAD                 @"v1/user/upload/"
///上传身份证等多张图片
#define METHOD_OF_IMAGES_UPLOAD          @"v1/fleamarket/imageupload?"
///完善资料
#define METHOD_OF_INFO_PERFECT           @"v1/courier/updateuserinfo?"
///根据关键字查询学校
#define METHOD_OF_COLLEGE_SEARCH         @"v1/college/search?"
///发快递取件消息接口(未完成取件)
#define METHOD_INCOMPLETE_COURIER_LIST   @"v1/courier/incomplete?"
///送快递记录
#define METHOD_SEND_COURIER_HISTORY      @"v1/courier/expressrecord?"
///快递确认已送达
#define METHOD_OF_COURIER_ARRIVE                @"v1/courier/finish?"

///发送单条短信
#define METHOD_OF_COURIER_SEND_SNS              @"v1/courier/sendsns?"
///群扫描后，保存手机号,快递单号
#define METHOD_OF_COURIER_SAVE_INFO_SNS         @"v1/courier/saveexpress?"
///根据快递单号，发送短信，多条短信
#define METHOD_OF_COURIER_SEND_MASS_SNS         @"v1/courier/sendmultisns?"
///若之前群发过，重新发送，则使用这个接口，无需写短信，因为服务器已经保存
#define METHOD_OF_COURIER_SEND_SNS_EXPRESSNO    @"v1/courier/sendsnsByExpressNo?"
///工作统计
#define METHOD_OF_COURIER_STATISTICS            @"v1/courier/statistics?"

#pragma mark - 送快递相关

///设置快递员上下班接口
#define METHOD_CONFIGURE_WORK                    @"v1/courier/working?"

///短信模板列表接口
#define METHOD_CONFIGURE_TEMPLATES_LIST          @"v1/templates/list?"
///添加短信模板接口
#define METHOD_CONFIGURE_TEMPLATES_CREATE        @"v1/templates/create?"
///修改短信模板接口
#define METHOD_CONFIGURE_TEMPLATES_UPDATE        @"v1/templates/update?"
///删除短信模板接口
#define METHOD_CONFIGURE_TEMPLATES_DELETE        @"v1/templates/delete?"




#pragma mark - 集梦盒子  二期
///用户登录
#define TWICE_METHOD_OF_LOGIN                       @"user/signin"
///修改密码 根据手机号更新密码
#define TWICE_METHOD_OF_UPDATE_PASSWORD             @"user/changepasswd"
///首页工作统计
#define TWICE_METHOD_OF_WORK_STATUS                 @"work/status"
///快递公司列表
#define TWICE_METHOD_OF_COURIER_COMPANY             @"expresscompany/list"
///完成入库
#define TWICE_METHOD_OF_RU_KU                       @"scan/warehouse"
///完成入货架
#define TWICE_METHOD_OF_RU_HUO_JIA                  @"scan/shelf"
///完成入货柜
#define TWICE_METHOD_OF_RU_HUO_GUI                  @"scan/container"
///获取空柜状态
#define TWICE_METHOD_OF_KONG_GUI_STATE              @"container/status"
///首页工作统计
#define TWICE_METHOD_OF_WORK_DETAILS                @"work/details"

#define METHOD_OF_ADD_ICON_UPLOAD                   @"user/upload"
#endif /* NetworkConfigue_h */
