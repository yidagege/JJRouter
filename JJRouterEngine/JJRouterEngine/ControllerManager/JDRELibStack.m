//
//  JJELibStack.m
//  JEREngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import "JJELibStack.h"
#import "JJETask.h"
#import "JJEApi.h"

NSString * const kJJELibTaskKey = @"com.JJ.engine.libtask";
extern int kJJRegisterPlayerBizID;

//为sharelib需要提供的类，记录当前模块
@implementation JJELibStack {
    NSMutableArray *_array;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
    }
    return self;
}

//因为登录模块总在栈顶，所以每次取栈顶下的元素
- (void)writeToFile:(id)obj
{
    if (obj == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kJJELibTaskKey];
    }
    else {
        if ([obj isKindOfClass:[JJETask class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"engine:%d", [[(JJETask *)obj engineObj] module]] forKey:kJJELibTaskKey];
        }
        else if ([obj isKindOfClass:[JJEModuleParameter class]]) {
            JJEModuleParameter *parameter = obj;
            NSDictionary *originalParams = [parameter.originalParams isKindOfClass:[NSDictionary class]] ? parameter.originalParams : nil;
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"register:%@", originalParams[@"biz_id"]] forKey:kJJELibTaskKey];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)push:(id)obj
{
    if (obj) {
        [self writeToFile:_array.lastObject];
        [_array addObject:obj];
    }
}

- (id)pop
{
    id obj = nil;
    
    if (_array.lastObject) {
        obj = _array.lastObject;
        [_array removeLastObject];
        if (_array.count > 1) {
            [self writeToFile:_array[_array.count - 2]];
        }
        else {
            [self writeToFile:nil];
        }
    }
    
    return obj;
}

- (void)deleteFirstPlayer:(BOOL)isRegister
{
    if (isRegister) {
        JJEModuleParameter *playerParameter = nil;
        for (JJEModuleParameter *parameter in _array) {
            if ([parameter isKindOfClass:[JJEModuleParameter class]]) {
                id biz_id = (parameter.originalParams)[@"biz_id"];
                if (([biz_id isKindOfClass:[NSString class]] || [biz_id isKindOfClass:[NSNumber class]]) && [biz_id intValue] == kJJRegisterPlayerBizID) {
                    playerParameter = parameter;
                    break;
                }
            }
        }
        
        if (playerParameter && playerParameter != _array.lastObject) {
            [_array removeObject:playerParameter];
        }
    }
    else {
        JJETask *playerTask = nil;
        for (JJETask *task in _array) {
            if ([task isKindOfClass:[JJETask class]] && task.engineObj.module == enumJJEModulePlayer && task.engineObj.type == JJEModulePlayerTypeDefault) {
                playerTask = task;
                break;
            }
        }
        
        if (playerTask && playerTask != _array.lastObject) {
            [_array removeObject:playerTask];
        }
    }
}

@end
