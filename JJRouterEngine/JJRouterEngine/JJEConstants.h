//
//  JJEConstants.h
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const JJEnginePluginName;//插件名
extern NSString * const JJEnginePluginVer;//插件版本号
extern NSString * const JJEnginePluginGrayVer;//插件灰度版本号
extern NSString * const JJEnginePluginErrorCode;//插件错误代码
extern NSString * const JJEnginePluginErrorMsg;//插件错误信息

extern NSString * const JJEngineErrorDomain;

///**
// *   Engine模块类型
// */
//typedef enum _JJEModuleType{
//    enumJJEModuleAll = -1,      //模块注册时，如果全部模块都支持，使用此参数
//    enumJJEModuleLogin = 1,     //登录注册
//    enumJJEModuleVIP,           //会员
//    enumJJEModulePlayer,        //播放器
//    enumJJEModuleMovieTicket,   //电影票
//    enumJJEModuleSearch,        //搜索
//    enumJJEModuleShare,          //分享
//    enumJJEModuleHome,           //基线相关页面
//    enumJJEModuleUGC,            //UGC
//    enumJJEModuleOffline,
//    enumJJEModuleFeedback,
//    /*业务模块*/
//    enumJJEModulePaoPao = 101,                //泡泡
//    enumJJEModulePPQ,                   //啪啪奇
//    enumJJEModuleReader                 //阅读
//}JJEModuleType;

/**
 *    Module 子类型
 */
//typedef enum _JJEModuleLoginType {
//    JJEModuleLoginTypeDefault,  //默认为登录界面
//    JJEModuleLoginTypeRegister,  //注册界面
//    JJEModuleLoginTypeBindPhone,  //绑定手机界面
//    JJEModuleLoginTypeLogout,  //退出
//    JJEModuleLoginTypeChangePhone, //修改手机号
//    JJEModuleLoginTypeDeviceManager,  //主设备
//    JJEModuleLoginTypeDeviceLock,//设备锁
//    JJEModuleLoginTypeAccountAuthorize,//账户授权
//    JJEModuleLoginTypeAccountChangePwd//修改密码
//    
//} JJEModuleLoginType;
//
//typedef enum _JJEModuleMovieTicketType {
//    JJEModuleMovieTicketTypeDefault,    //默认为打开电影票native
//    JJEModuleMovieTicketTypeURL,        //打开电影票活动
//    JJEModuleMovieTicketTypeSeat,       //选坐页
//    JJEModuleMovieTicketTypeOrder,       //订单页
//    JJEModuleMovieTicketTypeCouponList       //卡券页
//} JJEModuleMovieTicketType;
//
//typedef enum _JJEModuleQiXiuType {
//    JJEModuleQiXiuTypeDefault,  //默认为首页
//    JJEModuleQiXiuTypeLive  //直播
//} JJEModuleQiXiuType;
//
//typedef enum _JJEModulePlayerType {
//    JJEModulePlayerTypeDefault,          //打开播放器的默认设置
//    JJEModulePlayerTypePaopaoHasMini   //泡泡里有播放器的mini窗口
//} JJEModulePlayerType;
//
//typedef enum _JJEModuleVIPType {
//    JJEModuleVIPTypeBuyVIP,             //打开vip的购买
//    JJEModuleVIPTypeBuyMovieTicket,     //打开电影票购买
//    JJEModuleVIPTypeBuyVirtualCoin,      //打开虚拟币
//    JJEModuleVIPTypeBuyForEC,      //打开电商收银台 ElectronicCommerce
//    JJEModuleVIPTypeBuyForGeneralCashier,      //打开通用收银台
//    JJEModuleVIPTypeMyWallet,                   //打开我的钱包
//    JJEModuleVIPTypeVIPClub,                    //打开会员俱乐部
//    JJEModuleVIPTypeVIPChannel,                  //打开会员频道页
//    JJEModuleVIPCommonProblems,                  //VIP常见问题
//    JJEModulePaymentTypeIAP                  //调用IAP支付，无controller
//} JJEModuleVIPType;
//
//typedef enum _JJEModuleSearchType {
//    JJEModuleSearchTypeDefault,            //打开搜索
//    JJEModuleSearchTypeSearchByKeyword,    //给关键词搜索
//} JJEModuleSearchType;
//
//typedef enum _JJEModuleShareType {
//    JJEModuleShareTypeDefault,            //默认分享，有分享平台
//    JJEModuleShareTypeWithoutBtns         //没有分享平台UI
//} JJEModuleShareType;
//
//typedef enum _JJEModuleFeedbackType {
//    JJEModuleFeedbackTypeDefault
//} JJEModuleFeedbackType;
//
//typedef enum _JJEModulePaoPaoType {
//    JJEModulePaoPaoTypeStarWall,         //明星墙
//    JJEModulePaoPaoTypeChat,             //聊天页面
//    JJEModulePaoPaoTypeExplore,             //从探索页面进入
//    JJEModulePaoPaoTypeWithTvID,            //通过TVID进入
//    JJEModulePaoPaoTypeFromPlay,     //通过播放器进入泡泡
//    JJEModulePaoPaoTypeStarWallFromPlay, //从播放器进入明星墙
//    JJEModulePaoPaoTypeFromVote,     //通过投票
//    JJEModulePaoPaoTypeShareToPaoPao, //分享到泡泡
//    JJEModulePaoPaoTypeQRCodeToToPaoPao, //扫码进入泡泡
//    JJEModulePaoPaoTypeOpenMore, //泡泡打开更多页面
//    JJEModulePaoPaoTypeOpenH5, //泡泡打开H5
//    JJEModulePaoPaoTypeGroupChat, //泡泡打开群聊
//    JJEModulePaoPaoTypeCircle, //泡泡打开圈子
//    JJEModulePaoPaoTypePersonalProfile,//点击头像跳转个人详情页
//    JJEModulePaoPaoTypePersonalComment,//回复个人页面
//    JJEModulePaoPaoTypeReportCirclePage,//举报圈子
//    JJEModulePaoPaoTypeReportCommentPage,//举报评论
//    JJEModulePaoPaoTypeCirclePublishMent,//发布圈子状态
//    JJEModulePaoPaoTypeReportVotePage,//举报投票页
//    JJEModulePaoPaoTypeMyCirclePage,//进入我的圈子
//    JJEModulePaoPaoTypeMessageListPage,//进入消息列表页面
//    JJEModulePaoPaoTypeSearch,          //进入泡泡搜索
//    JJEModulePaoPaoTypeBuyProp,          //进入泡泡购买道具
//    JJEModulePaoPaoTypeSeedFeed          //文学圈子发布feed功能
//} JJEModulePaoPaoType;
//
//typedef enum _JJEModuleUGCType {
//    JJEModuleUGCTypeStar,             //明星页
//    JJEModuleUGCTypeQRCode            //扫一扫
//} JJEModuleUGCType;
//
//typedef enum _JJEModulePPQType {
//    JJEModulePPQTypePlayer,                 //啪啪奇的视频播放页
//    JJEModulePPQTypeUserSpace,              //啪啪奇的个人主页
//    JJEModulePPQTypeVideo,                  //啪啪奇交友内部集成的基线拍摄视频页
//    JJEModulePPQTypeMyVideos                //“我的视频”管理页
//} JJEModulePPQType;
//
//typedef enum _JJEModuleHomeType {
//    JJEModuleHomeTypeDefault,                    //基线首页
//    JJEModuleHomeTypeSecondPage,                 //基线通用card二级页
//    JJEModuleHomeTypeBindBaidu,                   //打通百度账号
//    JJEModuleHomeTypeOnlineService,                //在线客服
//    JJEModuleHomeTypeEditUserInfo,                  //编辑用户信息
//    JJEModuleHomeTypeOpenReciveTvAdMsg,              //展示多屏互动广告界面
//    JJEModuleHomeTypeDynamicList,                     //明星影响力榜
//    JJEModuleHomeTypeWebView,                     //基线webview
//    JJEModuleHomeTypeVipAutoRenew,
//    JJEModuleHomeTypeRemoveSubscriptionNewTag       //收藏更新提醒的需求  垂线有播放行为需要通知基线
//} JJEModuleHomeType;
//
//typedef enum _JJEModuleReaderType {
//    JJEModuleReaderTypeDefault,                 //阅读
//    JJEModuleReaderTypeLastBookInfo             //获取最近一条阅读记录
//} JJEModuleReaderType;
//
//typedef enum _JJEModuleOfflineType{
//    JJEModuleOfflineTypeDefault,        //默认打开离线界面
//    JJEModuleOfflineTypeFolder,
//    JJEModuleOfflineTypeNoDelete,        //不可删除模式
//    JJEModuleOfflineTypeIsDownloading,        //是否有下载任务正在下载
//} JJEModuleOfflineType;

