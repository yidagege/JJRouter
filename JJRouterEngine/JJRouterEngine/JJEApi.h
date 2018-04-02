//
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJEConstants.h"

@class JJEObject;
@class JJECallback;
@class JJEInterfaceManager;
@class JJEModuleParameter;

/**
 *
 *    @brief    调起某个模块
 *
 *    @param     obj     engine obj对象，不可为nil
 *  @see    JJEObject
 *    @param     callback    callback对象，如果不需要回调，可以为nil
 *  @see    JJECallback
 */
void JJEMsgSend(JJEObject *obj, JJECallback *callback);

/**
 *
 *    @brief    调起支持注册制的模块
 *
 *    @param     parameter
 *  @see    JJEModuleParameter
 */
void JJEOpenModule(JJEModuleParameter *parameter);


//此变量外部调试时可用，设为YES时在debug模式下打印log，否则不打印
extern BOOL isJJELogOpen;

FOUNDATION_EXPORT void JJELog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

/**
 此对象包含了要调起模块的相关信息
 */
@interface JJEObject : NSObject

/**
 *
 *    @brief    要调起的模块
 *  @see    JJEModuleType
 */
@property (nonatomic) int module;

/**
 *
 *    @brief    模块对应的某个类型，即模块对应的某个具体功能
 */
@property (nonatomic) int type;

/**
 *
 *    @brief    模块相关信息，包含了模块需要的参数
 */
@property (nonatomic, strong) NSDictionary *userInfo;

/**
 *
 *    @brief    创建一个JJEObject对象
 *
 *    @param     module     某个模块，参见JJEModuleType
 *    @param     type    模块对应的某个类型，即模块对应的某个具体功能
 *    @param     userinfo     调起模块时模块对应的参数
 *
 *    @return    JJEObject对象
 */
+ (instancetype)engineObjWithModule:(int)module type:(int)type andUserInfo:(NSDictionary *)userinfo;

@end

/**
 模块调用后使用的回调对象
 */
@interface JJECallback : NSObject

/**
 *
 *    @brief  selector被调用在的target
 */
@property (nonatomic, weak) id target;

/**
 *
 *    @brief    此方法将会在target上被调用
 *  @see    target
 *  @attention   The selector to be called on the target must be a method with the following signature:
 *                  - (void)selector:(JJECallbackData *)
 *                  callbackData
 *                  ;
 *               where callbackData is the JJECallbackData Object
 */
@property (nonatomic) SEL selector;

/**
 *
 *    @brief    创建一个JJECallback对象
 *
 *    @param     target     selector被调用在的target
 *    @param     selector     此方法将会在target上被调用
 *  @attention   The selector to be called on the target must be a method with the following signature:
 *                  - (void)selector:(JJECallbackData *)
 *                  callbackData
 *                  ;
 *               where callbackData is the JJECallbackData Object
 *
 *    @return    JJECallback对象
 */
+ (instancetype)callbackWithTarget:(id)target selector:(SEL)selector;

@end

/**
 callback方法对应的selector调用时所传的对象
 */
@interface JJECallbackData : NSObject

/**
 *
 *    @brief    回调数据出错时的错误
 */
@property (nonatomic, strong) NSError *error;

/**
 *
 *    @brief    回调模块返回的数据，此数据为一个接口
 */
@property (nonatomic, strong) NSDictionary *data;

/**
 是否调用完成，默认为YES，表示模块调用完成，如果标记为NO，将视为模块未退出
 */
@property (nonatomic) BOOL isFinished;

/**
 *
 *    @brief    创建一个JJECallbackData对象
 *
 *    @param     error   回调数据出错时的错误
 *    @param     data     回调模块返回的数据，此数据为一个接口
 *
 *    @return    JJECallbackData对象
 */
+ (instancetype)callbackDataWithError:(NSError *)error andData:(NSDictionary *)data;

@end
/**
 京东阅读引擎Api
 */
@interface JJEApi : NSObject
/**
 *
 *    @brief    设置接口管理器
 *
 *    @param     mgr     应该是JJEInterfaceManager的子类
 */
+ (void)setInterfaceMgr:(JJEInterfaceManager *)mgr;

/**
 *
 *    @brief    模块注册，已独立并可通过CC调起的模块必须先注册后，才能被调起
 *
 *    @param     type     JJEModuleType
 */
+ (void)moduleRegisterByType:(JJEModuleType)type;

#pragma mark - For register

/**
 *
 *    @brief    注册制中，业务模块要调用的方法，需要在业务模块中+ (void)load中调用此方法
 *
 *    @param     moduleID     注册的module id，由服务器规定
 *    @param     className     类名，需要实现JJEModuleProtocol协议中的方法
 */
+ (void)registerByModuleID:(NSString *)moduleID andClassName:(NSString *)className;

/**
 iPad使用注册制中，业务模块要调用的方法，需要在业务模块中+ (void)load中调用此方法
 
 @param moduleID 注册的module id，由服务器规定
 @param className 类名，需要实现JJEModuleProtocol协议中的方法
 */
+ (void)registerForPadByModuleID:(NSString *)moduleID andClassName:(NSString *)className;

+ (void)logForParam:(NSDictionary *)params;

@end

#pragma mark -

typedef void (^JJEModuleClose)(JJECallbackData *callbackData);
typedef void (^JJEModuleMessage)(NSDictionary *message);

@interface JJEModuleParameter : NSObject

/**
 *
 *    @brief    服务器原始数据字典
 */
@property (nonatomic, strong) NSDictionary *originalParams;

/**
 *
 *    @brief    模块需要的其他参数，由客户端提供（如统计入口参数、承载打开模块的controller或者view等）
 */
@property (nonatomic, strong) NSDictionary *otherParams;

/**
 当被调用的模块需要传递消息给调用者时，可以设置此block
 */
@property (nonatomic, copy) JJEModuleMessage messageCallBack;

/**
 *
 *    @brief    模块关闭时的回调，此方法在模块关闭时必须调用
 */
@property (nonatomic, copy) JJEModuleClose closeCallBack;

@end
