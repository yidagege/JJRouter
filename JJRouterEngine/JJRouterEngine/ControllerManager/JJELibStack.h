//
//  JJELibStack.h
//  JJEngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJELibStack : NSObject
- (void)push:(id)obj;
- (id)pop;

/**
 从堆栈中删除最早的player
 
 @param isRegister 是否为注册制删除
 */
- (void)deleteFirstPlayer:(BOOL)isRegister;

@end
