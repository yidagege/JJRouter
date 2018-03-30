//
//  JDREControllerCenter.h
//  JEREngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDREApi.h"

@class JDREInterfaceManager;
@class JDRECallbackData;


@interface JDREControlCenter : NSObject
@property (nonatomic, strong) JDREInterfaceManager* interfaceMgr;

/**
 *
 *    @brief    获取控制中心对象
 *
 *    @return    控制中心单例
 */
+ (instancetype)sharedInstance;

/**
 *
 *    @brief    获取已注册的模块
 *
 *    @return    模块数组
 */
- (NSArray *)moduleArray;


/**
 *
 *    @brief    模块注册，已独立并可通过CC调起的模块必须先注册后，才能被调起
 *
 *    @param     type     JDREModuleType
 */
- (void)moduleRegisterByType:(JDREModuleType)type;

/**
 *
 *    @brief    此方法在模块完成后，有回调的情况下应该被调用，处理JDRECallbackData对象，并回调模块的调用者
 *
 *    @param     callbackData     JDRECallbackData对象
 */
- (void)callbackWithData:(JDRECallbackData *)callbackData;

- (void)moduleRegisterByModuleID:(NSString *)moduleID andClassName:(NSString *)className;

- (void)handleModuleParameter:(JDREModuleParameter *)parameter;

@end
