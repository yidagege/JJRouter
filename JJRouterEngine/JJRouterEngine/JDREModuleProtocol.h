//
//  JDREModuleProtocol.h
//  JEREngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JDREModuleParameter;

@protocol JDREModuleProtocol <NSObject>

@required
+ (void)launchWithParam:(JDREModuleParameter *)param;
@optional
+ (NSDictionary *)moduleInfoWithParam:(JDREModuleParameter *)param;

@end

