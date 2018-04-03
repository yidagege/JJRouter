//
//  JJEControllerCenter.h
//  JJEngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJEApi.h"

@class JJECallbackData;


@interface JJEControlCenter : NSObject

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
 *    @param     type     JJEModuleType
 */
//- (void)moduleRegisterByType:(JJEModuleType)type;

/**
 *
 *    @brief    此方法在模块完成后，有回调的情况下应该被调用，处理JJECallbackData对象，并回调模块的调用者
 *
 *    @param     callbackData     JJECallbackData对象
 */
- (void)callbackWithData:(JJECallbackData *)callbackData;

- (void)moduleRegisterByModuleID:(NSString *)moduleID andClassName:(NSString *)className;

- (void)handleModuleParameter:(JJEModuleParameter *)parameter;

@end
