//
//  JDREInterfaceManager.h
//  JEREngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDREConstants.h"


@protocol JDREInterfaceManager <NSObject>

@optional
/**
 *    打开登录模块
 *
 *    @param userInfo   void
 *    @param type       注册或登录页
 */
- (void)openLogin:(NSDictionary *)params withType:(JDREModuleLoginType)type;

/**
 *
 *    @brief    打开电影票模块
 *
 *    @param     params     参数及返回值详情参阅电影票模块
 *    @param     type     电影票活动页或native页面
 */
- (void)openMovieTicket:(NSDictionary *)params withType:(JDREModuleMovieTicketType)type;

/**
 *
 *    @brief    打开播放器
 *
 *    @param     params  参数及返回值详情参阅播放器模块
 *    @param     type     JDREModulePlayerType
 */
- (void)openPlayer:(NSDictionary *)params withType:(JDREModulePlayerType)type;

/**
 *
 *    @brief    打开会员购买
 *
 *    @param     params     参数及返回值详情参阅会员模块
 *    @param     type     JDREModuleVIPType
 */
- (void)openVIP:(NSDictionary *)params withType:(JDREModuleVIPType)type;

/**
 *
 *    @brief    打开搜索
 *
 *    @param     params     参数及返回值详情参阅搜索模块
 *    @param     type     JDREModuleSearchType
 */
- (void)openSearch:(NSDictionary *)params withType:(JDREModuleSearchType)type;

/**
 *
 *    @brief    打开分享
 *
 *    @param     params     参数及返回值详情参阅搜索模块
 *    @param     type     JDREModuleShareType
 */
- (void)openShare:(NSDictionary *)params withType:(JDREModuleShareType)type;

/**
 *
 *    @brief    打开秀场
 *
 *    @param     params     参数及返回值详情参阅搜索模块
 *    @param     type     JDREModuleQiXiuType
 */
- (void)openQiXiu:(NSDictionary *)params withType:(JDREModuleQiXiuType)type;

/**
 *
 *    @brief    打开泡泡
 *
 *    @param     params     参数及返回值详情参阅泡泡模块
 *    @param     type     JDREModulePaoPaoType
 */
- (void)openPaoPao:(NSDictionary *)params withType:(JDREModulePaoPaoType)type;

/**
 *
 *    @brief    打开ugc
 *
 *    @param     params     参数及返回值详情参阅UGC模块
 *    @param     type     JDREModulePaoPaoType
 */
- (void)openUGC:(NSDictionary *)params withType:(JDREModuleUGCType)type;

/**
 *
 *    @brief    打开啪啪奇
 *
 *    @param     params     参数及返回值详情参阅泡泡模块
 *    @param     type     JDREModulePaoPaoType
 */
- (void)openPPQ:(NSDictionary *)params withType:(JDREModulePPQType)type;

/**
 *
 *    @brief    打开首页
 *
 *    @param     params     参数及返回值详情参阅首页模块
 *    @param     type     JDREModuleHomeType
 */
- (void)openHome:(NSDictionary *)params withType:(JDREModuleHomeType)type;

/**
 *
 *    @brief    打开阅读
 *
 *    @param     params     参数及返回值详情参阅模块
 *    @param     type     JDREModuleReaderType
 */
- (void)openReader:(NSDictionary *)params withType:(JDREModuleReaderType)type;

/**
 *
 *    @brief    打开离线页面
 *
 *    @param     params     参数及返回值详情参阅离线模块
 *    @param     type     JDREModuleOfflineType
 */
- (void)openOffline:(NSDictionary *)params withType:(JDREModuleOfflineType)type;

- (void)openFeedback:(NSDictionary *)params withType:(JDREModuleFeedbackType)type;


@end

@interface JDREInterfaceManager : NSObject<JDREInterfaceManager>

@end
