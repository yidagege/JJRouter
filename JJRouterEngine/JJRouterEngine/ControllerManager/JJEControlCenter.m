//
//  JJEControllerCenter.m
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import "JJEControlCenter.h"
#import "JJEModuleProtocol.h"
#import "JJELibStack.h"
#import <UIKit/UIKit.h>

static NSString * const kJJECurrentTaskKey = @"com.jj.engine.currenttask";
NSString * const JJEngineErrorDomain = @"com.jj.error.engine";


@interface JJEControlCenter()

@property (nonatomic, strong) NSMutableDictionary *moduleDic;
@property (nonatomic, strong) NSMutableArray *launchStack;
@property (nonatomic, strong) NSMutableArray *statusBarStack;
@property (nonatomic, strong) JJELibStack *libStack;

@end


@implementation JJEControlCenter
- (id)init
{
    if (self = [super init]) {
        isJJELogOpen = YES;
        
        _moduleDic = [NSMutableDictionary dictionary];
        _launchStack = [NSMutableArray array];
        _statusBarStack = [NSMutableArray array];
        _libStack = [[JJELibStack alloc] init];
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static JJEControlCenter *_instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _instance = self.new;
    });
    return _instance;
}


#pragma mark - for crash log

- (void)writeCurrentTasktoFile
{
    JJEModuleParameter *parameter = [_launchStack lastObject];
    
    if (parameter) {
        NSDictionary *originalParams = [parameter.originalParams isKindOfClass:[NSDictionary class]] ? parameter.originalParams : nil;
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", originalParams[@"biz_id"]] forKey:kJJECurrentTaskKey];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kJJECurrentTaskKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 注册制

- (void)launchModuleByClassName:(NSString *)className andParam:(JJEModuleParameter *)param
{
    [NSClassFromString(className) launchWithParam:param];
}

- (void)handleModuleParameter:(JJEModuleParameter *)parameter
{
    JJELog(@"注册制模块掉起，服务器参数：\n%@\n其他参数：\n%@", parameter.originalParams, parameter.otherParams);
    
    NSDictionary *originalParams = [parameter.originalParams isKindOfClass:[NSDictionary class]] ? parameter.originalParams : nil;
    
    if (!originalParams) {
        JJECallbackData *cbData = [[JJECallbackData alloc] init];
        cbData.error = [NSError errorWithDomain:JJEngineErrorDomain code:0 userInfo:@{@"name":@"data error"}];;
        parameter.closeCallBack(cbData);
        
        return;
    }
    
    NSString *className = _moduleDic[[NSString stringWithFormat:@"%@", originalParams[@"biz_id"]]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        className = _moduleDic[[NSString stringWithFormat:@"%@@@iPad", originalParams[@"biz_id"]]];
    }
    
    if (className) {
        if ([NSClassFromString(className) respondsToSelector:@selector(launchWithParam:)]) {
            
            //入栈
            [_launchStack addObject:parameter];
            [self writeCurrentTasktoFile];
            [_libStack push:parameter];
            
            JJEModuleParameter *tempParam = [[JJEModuleParameter alloc] init];
            tempParam.originalParams = parameter.originalParams;
            tempParam.otherParams = parameter.otherParams;
            tempParam.messageCallBack = parameter.messageCallBack;
            tempParam.closeCallBack = ^(JJECallbackData *cb) {
                
                JJEModuleParameter *p = _launchStack.lastObject;
                
                if (p) {
                    //出栈
                    [_launchStack removeLastObject];
                    [self writeCurrentTasktoFile];
                    [_libStack pop];
                    
                    if (p.closeCallBack) {
                        p.closeCallBack(cb);
                    }
                    
                    //恢复status bar状态
                    [self restoreStatusBarStyle];
                }
            };
            
            //for log
            NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:parameter.originalParams];
            
            if ([NSClassFromString(className) respondsToSelector:@selector(moduleInfoWithParam:)]) {
                NSDictionary  *dic = [NSClassFromString(className) moduleInfoWithParam:tempParam];
                if (dic) {
                    [muDic addEntriesFromDictionary:dic];
                }
            }
            
            
            //保存进入前status bar状态
            [self saveStatusBarStyle];
            
            [self launchModuleByClassName:className andParam:tempParam];
            [JJEApi logForParam:muDic];
        }
        else {
            JJECallbackData *cbData = [[JJECallbackData alloc] init];
            cbData.error = [NSError errorWithDomain:JJEngineErrorDomain code:0 userInfo:@{@"name":@"modules does not implement JJEModuleProtocol"}];;
            parameter.closeCallBack(cbData);
        }
    }
    else if (parameter.closeCallBack) {
        JJECallbackData *cbData = [[JJECallbackData alloc] init];
        cbData.error = [NSError errorWithDomain:JJEngineErrorDomain code:0 userInfo:@{@"name":@"modules does not register"}];;
        parameter.closeCallBack(cbData);
    }
}

#pragma mark - StatusBarStyle

- (void)restoreStatusBarStyle
{
    NSNumber *statusObj = _statusBarStack.lastObject;
    if (statusObj != nil) {
        [[UIApplication sharedApplication] setStatusBarStyle:statusObj.intValue];
        [_statusBarStack removeLastObject];
    }
}

- (void)saveStatusBarStyle
{
    [_statusBarStack addObject:[NSNumber numberWithInt:[UIApplication sharedApplication].statusBarStyle]];
}

#pragma mark -

- (void)moduleRegisterByModuleID:(NSString *)moduleID andClassName:(NSString *)className
{
    if (moduleID && className && !_moduleDic[moduleID]) {
        [_moduleDic setObject:className forKey:moduleID];
    }
}


@end
