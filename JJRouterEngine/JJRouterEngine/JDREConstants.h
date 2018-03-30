//
//  JDREConstants.h
//  JEREngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const JDREnginePluginName;//插件名
extern NSString * const JDREnginePluginVer;//插件版本号
extern NSString * const JDREnginePluginGrayVer;//插件灰度版本号
extern NSString * const JDREnginePluginErrorCode;//插件错误代码
extern NSString * const JDREnginePluginErrorMsg;//插件错误信息

extern NSString * const JDREngineErrorDomain;

/**
 *   Engine模块类型
 */
typedef enum _JDREModuleType{
    enumJDREModuleAll = -1,      //模块注册时，如果全部模块都支持，使用此参数
    enumJDREModuleLogin = 1,     //登录注册
    enumJDREModuleVIP,           //会员
    enumJDREModulePlayer,        //播放器
    enumJDREModuleMovieTicket,   //电影票
    enumJDREModuleSearch,        //搜索
    enumJDREModuleShare,          //分享
    enumJDREModuleHome,           //基线相关页面
    enumJDREModuleUGC,            //UGC
    enumJDREModuleOffline,
    enumJDREModuleFeedback,
    /*业务模块*/
    enumJDREModulePaoPao = 101,                //泡泡
    enumJDREModulePPQ,                   //啪啪奇
    enumJDREModuleReader                 //阅读
}JDREModuleType;

/**
 *    Module 子类型
 */
typedef enum _JDREModuleLoginType {
    JDREModuleLoginTypeDefault,  //默认为登录界面
    JDREModuleLoginTypeRegister,  //注册界面
    JDREModuleLoginTypeBindPhone,  //绑定手机界面
    JDREModuleLoginTypeLogout,  //退出
    JDREModuleLoginTypeChangePhone, //修改手机号
    JDREModuleLoginTypeDeviceManager,  //主设备
    JDREModuleLoginTypeDeviceLock,//设备锁
    JDREModuleLoginTypeAccountAuthorize,//账户授权
    JDREModuleLoginTypeAccountChangePwd//修改密码
    
} JDREModuleLoginType;

typedef enum _JDREModuleMovieTicketType {
    JDREModuleMovieTicketTypeDefault,    //默认为打开电影票native
    JDREModuleMovieTicketTypeURL,        //打开电影票活动
    JDREModuleMovieTicketTypeSeat,       //选坐页
    JDREModuleMovieTicketTypeOrder,       //订单页
    JDREModuleMovieTicketTypeCouponList       //卡券页
} JDREModuleMovieTicketType;

typedef enum _JDREModuleQiXiuType {
    JDREModuleQiXiuTypeDefault,  //默认为首页
    JDREModuleQiXiuTypeLive  //直播
} JDREModuleQiXiuType;

typedef enum _JDREModulePlayerType {
    JDREModulePlayerTypeDefault,          //打开播放器的默认设置
    JDREModulePlayerTypePaopaoHasMini   //泡泡里有播放器的mini窗口
} JDREModulePlayerType;

typedef enum _JDREModuleVIPType {
    JDREModuleVIPTypeBuyVIP,             //打开vip的购买
    JDREModuleVIPTypeBuyMovieTicket,     //打开电影票购买
    JDREModuleVIPTypeBuyVirtualCoin,      //打开虚拟币
    JDREModuleVIPTypeBuyForEC,      //打开电商收银台 ElectronicCommerce
    JDREModuleVIPTypeBuyForGeneralCashier,      //打开通用收银台
    JDREModuleVIPTypeMyWallet,                   //打开我的钱包
    JDREModuleVIPTypeVIPClub,                    //打开会员俱乐部
    JDREModuleVIPTypeVIPChannel,                  //打开会员频道页
    JDREModuleVIPCommonProblems,                  //VIP常见问题
    JDREModulePaymentTypeIAP                  //调用IAP支付，无controller
} JDREModuleVIPType;

typedef enum _JDREModuleSearchType {
    JDREModuleSearchTypeDefault,            //打开搜索
    JDREModuleSearchTypeSearchByKeyword,    //给关键词搜索
} JDREModuleSearchType;

typedef enum _JDREModuleShareType {
    JDREModuleShareTypeDefault,            //默认分享，有分享平台
    JDREModuleShareTypeWithoutBtns         //没有分享平台UI
} JDREModuleShareType;

typedef enum _JDREModuleFeedbackType {
    JDREModuleFeedbackTypeDefault
} JDREModuleFeedbackType;

typedef enum _JDREModulePaoPaoType {
    JDREModulePaoPaoTypeStarWall,         //明星墙
    JDREModulePaoPaoTypeChat,             //聊天页面
    JDREModulePaoPaoTypeExplore,             //从探索页面进入
    JDREModulePaoPaoTypeWithTvID,            //通过TVID进入
    JDREModulePaoPaoTypeFromPlay,     //通过播放器进入泡泡
    JDREModulePaoPaoTypeStarWallFromPlay, //从播放器进入明星墙
    JDREModulePaoPaoTypeFromVote,     //通过投票
    JDREModulePaoPaoTypeShareToPaoPao, //分享到泡泡
    JDREModulePaoPaoTypeQRCodeToToPaoPao, //扫码进入泡泡
    JDREModulePaoPaoTypeOpenMore, //泡泡打开更多页面
    JDREModulePaoPaoTypeOpenH5, //泡泡打开H5
    JDREModulePaoPaoTypeGroupChat, //泡泡打开群聊
    JDREModulePaoPaoTypeCircle, //泡泡打开圈子
    JDREModulePaoPaoTypePersonalProfile,//点击头像跳转个人详情页
    JDREModulePaoPaoTypePersonalComment,//回复个人页面
    JDREModulePaoPaoTypeReportCirclePage,//举报圈子
    JDREModulePaoPaoTypeReportCommentPage,//举报评论
    JDREModulePaoPaoTypeCirclePublishMent,//发布圈子状态
    JDREModulePaoPaoTypeReportVotePage,//举报投票页
    JDREModulePaoPaoTypeMyCirclePage,//进入我的圈子
    JDREModulePaoPaoTypeMessageListPage,//进入消息列表页面
    JDREModulePaoPaoTypeSearch,          //进入泡泡搜索
    JDREModulePaoPaoTypeBuyProp,          //进入泡泡购买道具
    JDREModulePaoPaoTypeSeedFeed          //文学圈子发布feed功能
} JDREModulePaoPaoType;

typedef enum _JDREModuleUGCType {
    JDREModuleUGCTypeStar,             //明星页
    JDREModuleUGCTypeQRCode            //扫一扫
} JDREModuleUGCType;

typedef enum _JDREModulePPQType {
    JDREModulePPQTypePlayer,                 //啪啪奇的视频播放页
    JDREModulePPQTypeUserSpace,              //啪啪奇的个人主页
    JDREModulePPQTypeVideo,                  //啪啪奇交友内部集成的基线拍摄视频页
    JDREModulePPQTypeMyVideos                //“我的视频”管理页
} JDREModulePPQType;

typedef enum _JDREModuleHomeType {
    JDREModuleHomeTypeDefault,                    //基线首页
    JDREModuleHomeTypeSecondPage,                 //基线通用card二级页
    JDREModuleHomeTypeBindBaidu,                   //打通百度账号
    JDREModuleHomeTypeOnlineService,                //在线客服
    JDREModuleHomeTypeEditUserInfo,                  //编辑用户信息
    JDREModuleHomeTypeOpenReciveTvAdMsg,              //展示多屏互动广告界面
    JDREModuleHomeTypeDynamicList,                     //明星影响力榜
    JDREModuleHomeTypeWebView,                     //基线webview
    JDREModuleHomeTypeVipAutoRenew,
    JDREModuleHomeTypeRemoveSubscriptionNewTag       //收藏更新提醒的需求  垂线有播放行为需要通知基线
} JDREModuleHomeType;

typedef enum _JDREModuleReaderType {
    JDREModuleReaderTypeDefault,                 //阅读
    JDREModuleReaderTypeLastBookInfo             //获取最近一条阅读记录
} JDREModuleReaderType;

typedef enum _JDREModuleOfflineType{
    JDREModuleOfflineTypeDefault,        //默认打开离线界面
    JDREModuleOfflineTypeFolder,
    JDREModuleOfflineTypeNoDelete,        //不可删除模式
    JDREModuleOfflineTypeIsDownloading,        //是否有下载任务正在下载
} JDREModuleOfflineType;
