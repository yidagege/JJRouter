//
//  JJEModuleProtocol.h
//  JJEngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JJEModuleParameter;

@protocol JJEModuleProtocol <NSObject>

@required
+ (void)launchWithParam:(JJEModuleParameter *)param;
@optional
+ (NSDictionary *)moduleInfoWithParam:(JJEModuleParameter *)param;

@end

