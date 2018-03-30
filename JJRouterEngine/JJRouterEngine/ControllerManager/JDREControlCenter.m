//
//  JDREControllerCenter.m
//  JEREngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import "JDREControlCenter.h"
#import "JDREChecker.h"
#import "JDREConstants.h"
#import "JDREModuleProtocol.h"
#import "JDRELibStack.h"
#import <UIKit/UIKit.h>

static NSString * const kJDRECurrentTaskKey = @"com.JDR.engine.currenttask";
int const kJDRRegisterPlayerBizID = 102;

@interface JDREControlCenter()

@property (nonatomic, strong) JDREChecker *checker;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) NSMutableDictionary *moduleDic;
@property (nonatomic, strong) NSMutableArray *launchStack;
@property (nonatomic, strong) NSMutableArray *statusBarStack;
@property (nonatomic, strong) JDRELibStack *libStack;

@end


@implementation JDREControlCenter
- (id)init
{
    if (self = [super init]) {
        isJDRELogOpen = YES;
        
        _checker = [[JDREChecker alloc] init];
        _typeArray = [NSMutableArray array];
        _moduleDic = [NSMutableDictionary dictionary];
        _launchStack = [NSMutableArray array];
        _statusBarStack = [NSMutableArray array];
        _libStack = [[JDRELibStack alloc] init];
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static JDREControlCenter *_instance = nil;
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

//- (void)handleMsgObj:(JDREObject *)obj andCallback:(JDRECallback *)callback
//{
//    NSParameterAssert(obj);
//
//    NSError *error = nil;
//
//    if ([obj isKindOfClass:[JDREObject class]] && obj.module > 0) {
//        if ([_checker check:obj]) { //检查模块间依赖
//            //调用解析模块解析
//            JDRETask *task = [_parser parseEngineObj:obj andCallback:callback error:&error];
//            if (task) {
//                if ([self shouldIntoStack:task]) {
//                    [_taskStack push:task];
//                    [_libStack push:task];
//                }
//                [_actionHandler handleTask:task];
//            }else {
//                [self callback:callback withError:error andData:nil];
//            }
//        }else{
//            error = [NSError errorWithDomain:JDREngineErrorDomain code:0 userInfo:@{@"name":@"modules dependency is invalid"}];
//            [self callback:callback withError:error andData:nil];
//        }
//    }
//    else {
//        error = [NSError errorWithDomain:JDREngineErrorDomain code:0 userInfo:@{@"name":@"parameter is invalid"}];
//        [self callback:callback withError:error andData:nil];
//    }
//}


#pragma mark - for crash log

- (void)writeCurrentTasktoFile
{
    JDREModuleParameter *parameter = [_launchStack lastObject];
    
    if (parameter) {
        NSDictionary *originalParams = [parameter.originalParams isKindOfClass:[NSDictionary class]] ? parameter.originalParams : nil;
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", originalParams[@"biz_id"]] forKey:kJDRECurrentTaskKey];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kJDRECurrentTaskKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 注册制

- (void)launchModuleByClassName:(NSString *)className andParam:(JDREModuleParameter *)param
{
    [NSClassFromString(className) launchWithParam:param];
}

- (void)handleModuleParameter:(JDREModuleParameter *)parameter
{
    JDRELog(@"注册制模块掉起，服务器参数：\n%@\n其他参数：\n%@", parameter.originalParams, parameter.otherParams);
    
    NSDictionary *originalParams = [parameter.originalParams isKindOfClass:[NSDictionary class]] ? parameter.originalParams : nil;
    
    if (!originalParams) {
        JDRECallbackData *cbData = [[JDRECallbackData alloc] init];
        cbData.error = [NSError errorWithDomain:JDREngineErrorDomain code:0 userInfo:@{@"name":@"data error"}];;
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
            
            JDREModuleParameter *tempParam = [[JDREModuleParameter alloc] init];
            tempParam.originalParams = parameter.originalParams;
            tempParam.otherParams = parameter.otherParams;
            tempParam.messageCallBack = parameter.messageCallBack;
            tempParam.closeCallBack = ^(JDRECallbackData *cb) {
                ////播放器特殊逻辑，删除第一个播放器
                NSDictionary *dicData = cb.data;
                NSNumber *shouldDeleteFirstPlayer = dicData[@"shouldDeleteFirstPlayer"];
                
                if (shouldDeleteFirstPlayer && [shouldDeleteFirstPlayer isKindOfClass:[NSNumber class]] && shouldDeleteFirstPlayer.boolValue) {
                    [self deleteFirstPlayer:cb];
                    return;
                }
                ////
                
                JDREModuleParameter *p = _launchStack.lastObject;
                
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
            [JDREApi logForParam:muDic];
        }
        else {
            JDRECallbackData *cbData = [[JDRECallbackData alloc] init];
            cbData.error = [NSError errorWithDomain:JDREngineErrorDomain code:0 userInfo:@{@"name":@"modules does not implement JDREModuleProtocol"}];;
            parameter.closeCallBack(cbData);
        }
    }
    else if (parameter.closeCallBack) {
        JDRECallbackData *cbData = [[JDRECallbackData alloc] init];
        cbData.error = [NSError errorWithDomain:JDREngineErrorDomain code:0 userInfo:@{@"name":@"modules does not register"}];;
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

- (void)deleteFirstPlayer:(JDRECallbackData *)cb
{
    NSDictionary *data = cb.data;
    
    JDREModuleParameter *playerParameter = nil;
    for (JDREModuleParameter *parameter in _launchStack) {
        id biz_id = (parameter.originalParams)[@"biz_id"];
        if (([biz_id isKindOfClass:[NSString class]] || [biz_id isKindOfClass:[NSNumber class]]) && [biz_id intValue] == kJDRRegisterPlayerBizID) {
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

- (void)moduleRegisterByType:(JDREModuleType)type
{
    if (type && ![_typeArray containsObject:[NSNumber numberWithInt:type]]) {
        [_typeArray addObject:[NSNumber numberWithInt:type]];
    }
}

////回调给模块调用方
//- (void)callbackWithData:(JDRECallbackData *)callbackData
//{
//    if (callbackData && [callbackData isKindOfClass:[JDRECallbackData class]]) {
//        if ([callbackData.data isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *data = callbackData.data;
//            NSNumber *shouldDeleteFirstPlayer = data[@"shouldDeleteFirstPlayer"];
//            
//            if (shouldDeleteFirstPlayer && [shouldDeleteFirstPlayer isKindOfClass:[NSNumber class]] && shouldDeleteFirstPlayer.boolValue) {
//                //这里耦合了业务逻辑，当播放器调用此方法时，从堆栈中删掉之前的播放器，并且删除播放器时不回调
//                JDRETask *task = [_taskStack deletePlayer];
//                [_libStack deleteFirstPlayer:NO];
//                
//                NSNumber *shouldCallBack = data[@"shouldCallBack"];
//                if (task && shouldCallBack && [shouldCallBack isKindOfClass:[NSNumber class]] && shouldCallBack.boolValue) {
//                    [self callback:task.engineCallback withError:callbackData.error andData:callbackData.data];
//                }
//                
//                return;
//            }
//        }
//        
//        JDRETask *task = [_taskStack topTask];
//        
//        //模块调用完成，需要出栈
//        if (callbackData.isFinished) {
//            [_taskStack pop];
//            [_libStack pop];
//        }
//        
//        [self callback:task.engineCallback withError:callbackData.error andData:callbackData.data];
//    }
//}

#pragma mark -

- (void)callback:(JDRECallback *)callback withError:(NSError *)error andData:(NSDictionary *)data
{
    if (callback
        && [callback isKindOfClass:[JDRECallback class]]
        && [callback.target respondsToSelector:callback.selector]) {
        JDRECallbackData *cbData = [[JDRECallbackData alloc] init];
        cbData.error = error;
        cbData.data = data;
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [callback.target performSelector:callback.selector withObject:cbData];
#pragma clang diagnostic pop
    }
}

@end
