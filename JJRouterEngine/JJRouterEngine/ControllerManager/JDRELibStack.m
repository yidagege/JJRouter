//
//  JDRELibStack.m
//  JEREngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import "JDRELibStack.h"
#import "JDRETask.h"
#import "JDREApi.h"

NSString * const kJDRELibTaskKey = @"com.JDR.engine.libtask";
extern int kJDRRegisterPlayerBizID;

//为sharelib需要提供的类，记录当前模块
@implementation JDRELibStack {
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
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kJDRELibTaskKey];
    }
    else {
        if ([obj isKindOfClass:[JDRETask class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"engine:%d", [[(JDRETask *)obj engineObj] module]] forKey:kJDRELibTaskKey];
        }
        else if ([obj isKindOfClass:[JDREModuleParameter class]]) {
            JDREModuleParameter *parameter = obj;
            NSDictionary *originalParams = [parameter.originalParams isKindOfClass:[NSDictionary class]] ? parameter.originalParams : nil;
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"register:%@", originalParams[@"biz_id"]] forKey:kJDRELibTaskKey];
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
        JDREModuleParameter *playerParameter = nil;
        for (JDREModuleParameter *parameter in _array) {
            if ([parameter isKindOfClass:[JDREModuleParameter class]]) {
                id biz_id = (parameter.originalParams)[@"biz_id"];
                if (([biz_id isKindOfClass:[NSString class]] || [biz_id isKindOfClass:[NSNumber class]]) && [biz_id intValue] == kJDRRegisterPlayerBizID) {
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
        JDRETask *playerTask = nil;
        for (JDRETask *task in _array) {
            if ([task isKindOfClass:[JDRETask class]] && task.engineObj.module == enumJDREModulePlayer && task.engineObj.type == JDREModulePlayerTypeDefault) {
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
