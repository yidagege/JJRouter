//
//  JJEApi.m
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import "JJEApi.h"
#import "JJEControlCenter.h"

@implementation JJECallbackData

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
    JJECallbackData *cbData = [[JJECallbackData alloc] init];
    cbData.error = error;
    cbData.data = data;
    
    return cbData;
}

@end


void JJEOpenModule(JJEModuleParameter *parameter)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[JJEControlCenter sharedInstance] handleModuleParameter:parameter];
    });
}

BOOL isJJELogOpen = NO;

void JJELog(NSString *format, ...) {
#ifdef DEBUG
    if (isJJELogOpen) {
        NSLog(@"************* JJEngine log start *************");
        va_list args;
        va_start(args, format);
        NSLogv(format, args);
        va_end(args);
        NSLog(@"************* JJEngine log end *************");
    }
#endif
}

@implementation JJEApi

+ (void)registerByModuleID:(NSString *)moduleID andClassName:(NSString *)className
{
    [[JJEControlCenter sharedInstance] moduleRegisterByModuleID:moduleID andClassName:className];
}

+ (void)registerForPadByModuleID:(NSString *)moduleID andClassName:(NSString *)className
{
    [[JJEControlCenter sharedInstance] moduleRegisterByModuleID:[NSString stringWithFormat:@"%@@@iPad", moduleID] andClassName:className];
}

+ (void)logForParam:(NSDictionary *)params
{
    
}
@end

@implementation JJEModuleParameter

@end
