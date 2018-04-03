//
//  JJEInterfaceManager.h
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJEConstants.h"


@protocol JJEInterfaceManager <NSObject>

@optional
/**
 *    打开登录模块
 *
 *    @param userInfo   void
// *    @param type       注册或登录页
// */
//- (void)openLogin:(NSDictionary *)params withType:(JJEModuleLoginType)type;
//
///**
// *
// *    @brief    打开电影票模块
// *
// *    @param     params     参数及返回值详情参阅电影票模块
// *    @param     type     电影票活动页或native页面
// */
//- (void)openMovieTicket:(NSDictionary *)params withType:(JJEModuleMovieTicketType)type;
//
///**
// *
// *
// *    @param     params  参数及返回值详情参阅播放器模块
// *    @param     type     JJEModulePlayerType
// */
//- (void)openPlayer:(NSDictionary *)params withType:(JJEModulePlayerType)type;
//
///**
// *
// *    @brief    打开会员购买
// *
// *    @param     params     参数及返回值详情参阅会员模块
// *    @param     type     JJEModuleVIPType
// */
//- (void)openVIP:(NSDictionary *)params withType:(JJEModuleVIPType)type;
//
///**
// *
// *    @brief    打开搜索
// *
// *    @param     params     参数及返回值详情参阅搜索模块
// *    @param     type     JJEModuleSearchType
// */
//- (void)openSearch:(NSDictionary *)params withType:(JJEModuleSearchType)type;
//
///**
// *
// *    @brief    打开分享
// *
// *    @param     params     参数及返回值详情参阅搜索模块
// *    @param     type     JJEModuleShareType
// */
//- (void)openShare:(NSDictionary *)params withType:(JJEModuleShareType)type;
//
///**
// *
// *    @brief    打开秀场
// *
// *    @param     params     参数及返回值详情参阅搜索模块
// *    @param     type     JJEModuleQiXiuType
// */
//- (void)openQiXiu:(NSDictionary *)params withType:(JJEModuleQiXiuType)type;
//
///**
// *
// *    @brief    打开泡泡
// *
// *    @param     params     参数及返回值详情参阅泡泡模块
// *    @param     type     JJEModulePaoPaoType
// */
//- (void)openPaoPao:(NSDictionary *)params withType:(JJEModulePaoPaoType)type;
//
///**
// *
// *    @brief    打开ugc
// *
// *    @param     params     参数及返回值详情参阅UGC模块
// *    @param     type     JJEModulePaoPaoType
// */
//- (void)openUGC:(NSDictionary *)params withType:(JJEModuleUGCType)type;
//
///**
// *
// *    @brief    打开啪啪奇
// *
// *    @param     params     参数及返回值详情参阅泡泡模块
// *    @param     type     JJEModulePaoPaoType
// */
//- (void)openPPQ:(NSDictionary *)params withType:(JJEModulePPQType)type;
//
///**
// *
// *    @brief    打开首页
// *
// *    @param     params     参数及返回值详情参阅首页模块
// *    @param     type     JJEModuleHomeType
// */
//- (void)openHome:(NSDictionary *)params withType:(JJEModuleHomeType)type;
//
///**
// *
// *    @brief    打开阅读
// *
// *    @param     params     参数及返回值详情参阅模块
// *    @param     type     JJEModuleReaderType
// */
//- (void)openReader:(NSDictionary *)params withType:(JJEModuleReaderType)type;
//
///**
// *
// *    @brief    打开离线页面
// *
// *    @param     params     参数及返回值详情参阅离线模块
// *    @param     type     JJEModuleOfflineType
// */
//- (void)openOffline:(NSDictionary *)params withType:(JJEModuleOfflineType)type;
//
//- (void)openFeedback:(NSDictionary *)params withType:(JJEModuleFeedbackType)type;


@end

@interface JJEInterfaceManager : NSObject<JJEInterfaceManager>

@end
