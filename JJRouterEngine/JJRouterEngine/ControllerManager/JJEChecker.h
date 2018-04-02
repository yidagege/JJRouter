//
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JJEObject;

@interface JJEChecker : NSObject
/**
 *    检查发起模块调用的目的模块版本是否匹配
 *
 *    @param callObj (JJEObject)
 *
 *    @return YES/NO
 */
- (BOOL)check:(JJEObject*)callObj;

@end