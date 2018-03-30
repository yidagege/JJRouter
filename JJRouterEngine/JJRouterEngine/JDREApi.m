//
//  JDREApi.m
//  JEREngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import "JDREApi.h"
#import "JDREControlCenter.h"
@implementation JDREObject

+ (instancetype)engineObjWithModule:(int)module type:(int)type andUserInfo:(NSDictionary *)userinfo
{
    JDREObject *obj = [[JDREObject alloc] init];
    obj.module = module;
    obj.type = type;
    obj.userInfo = userinfo;
    
    return obj;
}

@end

@implementation JDRECallback

+ (instancetype)callbackWithTarget:(id)target selector:(SEL)selector
{
    JDRECallback *callback = [[JDRECallback alloc] init];
    callback.target = target;
    callback.selector = selector;
    
    return callback;
}

@end

@implementation JDRECallbackData

- (id)init
{
    if (self = [super init]) {
        _error = nil;
        _data = nil;
        _isFinished = YES;
    }
    return self;
}

+ (instancetype)callbackDataWithError:(NSError *)error andData:(NSDictionary *)data
{
    JDRECallbackData *cbData = [[JDRECallbackData alloc] init];
    cbData.error = error;
    cbData.data = data;
    
    return cbData;
}

@end


void JDREOpenModule(JDREModuleParameter *parameter)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[JDREControlCenter sharedInstance] handleModuleParameter:parameter];
    });
}

BOOL isJDRELogOpen = NO;

void JDRELog(NSString *format, ...) {
#ifdef DEBUG
    if (isJDRELogOpen) {
        NSLog(@"************* JDREngine log start *************");
        va_list args;
        va_start(args, format);
        NSLogv(format, args);
        va_end(args);
        NSLog(@"************* JDREngine log end *************");
    }
#endif
}

@implementation JDREApi
+ (void)setInterfaceMgr:(JDREInterfaceManager *)mgr
{
    [JDREControlCenter sharedInstance].interfaceMgr = mgr;
}

+ (void)moduleRegisterByType:(JDREModuleType)type
{
    [[JDREControlCenter sharedInstance] moduleRegisterByType:type];
}

//+ (void)moduleFinishedWithCallbackData:(JDRECallbackData *)callbackData
//{
//    [[JDREControlCenter sharedInstance] callbackWithData:callbackData];
//}

+ (void)registerByModuleID:(NSString *)moduleID andClassName:(NSString *)className
{
    [[JDREControlCenter sharedInstance] moduleRegisterByModuleID:moduleID andClassName:className];
}

+ (void)registerForPadByModuleID:(NSString *)moduleID andClassName:(NSString *)className
{
    [[JDREControlCenter sharedInstance] moduleRegisterByModuleID:[NSString stringWithFormat:@"%@@@iPad", moduleID] andClassName:className];
}

+ (void)logForParam:(NSDictionary *)params
{
    
}
@end

@implementation JDREModuleParameter

@end
