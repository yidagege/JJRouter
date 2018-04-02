//
//  JJEControllerCenter.m
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import "JJEControlCenter.h"
#import "JJEChecker.h"
#import "JJEConstants.h"
#import "JJEModuleProtocol.h"
#import "JJELibStack.h"
#import <UIKit/UIKit.h>

static NSString * const kJJECurrentTaskKey = @"com.JJ.engine.currenttask";
int const kJJRegisterPlayerBizID = 102;

@interface JJEControlCenter()

@property (nonatomic, strong) JJEChecker *checker;
@property (nonatomic, strong) NSMutableArray *typeArray;
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
        
        _checker = [[JJEChecker alloc] init];
        _typeArray = [NSMutableArray array];
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

- (NSArray *)moduleArray
{
    return [NSArray arrayWithArray:_typeArray];
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
    
    //
    if (className) {
        if ([NSClassFromString(className) respondsToSelector:@selector(launchWithParam:)]) {
            //8.0版本新增了打开类型
            if ([parameter.otherParams[@"openType"] isKindOfClass:[NSString class]] && [parameter.otherParams[@"openType"] isEqualToString:@"messageOnly"]) {
                [self launchModuleByClassName:className andParam:parameter];
                
                return;
            }
            
            //入栈
            [_launchStack addObject:parameter];
            [self writeCurrentTasktoFile];
            [_libStack push:parameter];
            
            JJEModuleParameter *tempParam = [[JJEModuleParameter alloc] init];
            tempParam.originalParams = parameter.originalParams;
            tempParam.otherParams = parameter.otherParams;
            tempParam.messageCallBack = parameter.messageCallBack;
            tempParam.closeCallBack = ^(JJECallbackData *cb) {
                ////播放器特殊逻辑，删除第一个播放器
                NSDictionary *dicData = cb.data;
                NSNumber *shouldDeleteFirstPlayer = dicData[@"shouldDeleteFirstPlayer"];
                
                if (shouldDeleteFirstPlayer && [shouldDeleteFirstPlayer isKindOfClass:[NSNumber class]] && shouldDeleteFirstPlayer.boolValue) {
                    [self deleteFirstPlayer:cb];
                    return;
                }
                ////
                
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

- (void)deleteFirstPlayer:(JJECallbackData *)cb
{
    NSDictionary *data = cb.data;
    
    JJEModuleParameter *playerParameter = nil;
    for (JJEModuleParameter *parameter in _launchStack) {
        id biz_id = (parameter.originalParams)[@"biz_id"];
        if (([biz_id isKindOfClass:[NSString class]] || [biz_id isKindOfClass:[NSNumber class]]) && [biz_id intValue] == kJJRegisterPlayerBizID) {
            playerParameter = parameter;
            break;
        }
    }
    
    if (playerParameter && playerParameter != _launchStack.lastObject) {
        [_launchStack removeObject:playerParameter];
    }
    
    [self writeCurrentTasktoFile];
    [_libStack deleteFirstPlayer:YES];
    
    NSNumber *shouldCallBack = data[@"shouldCallBack"];
    
    if (shouldCallBack && [shouldCallBack isKindOfClass:[NSNumber class]] && shouldCallBack.boolValue) {
        if (playerParameter.closeCallBack) {
            playerParameter.closeCallBack(cb);
        }
    }
}

- (void)moduleRegisterByModuleID:(NSString *)moduleID andClassName:(NSString *)className
{
    if (moduleID && className && !_moduleDic[moduleID]) {
        [_moduleDic setObject:className forKey:moduleID];
    }
}

#pragma mark - old engine callback

- (void)moduleRegisterByType:(JJEModuleType)type
{
    if (type && ![_typeArray containsObject:[NSNumber numberWithInt:type]]) {
        [_typeArray addObject:[NSNumber numberWithInt:type]];
    }
}

#pragma mark -

- (void)callback:(JJECallback *)callback withError:(NSError *)error andData:(NSDictionary *)data
{
    if (callback
        && [callback isKindOfClass:[JJECallback class]]
        && [callback.target respondsToSelector:callback.selector]) {
        JJECallbackData *cbData = [[JJECallbackData alloc] init];
        cbData.error = error;
        cbData.data = data;
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [callback.target performSelector:callback.selector withObject:cbData];
#pragma clang diagnostic pop
    }
}

@end
