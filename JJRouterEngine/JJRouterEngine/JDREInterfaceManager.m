//
//  JDREInterfaceManager.m
//  JEREngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import "JDREInterfaceManager.h"

@implementation JDREInterfaceManager
- (void)openLogin:(NSDictionary *)params withType:(JDREModuleLoginType)type
{
    //implemented by subclass
}

- (void)openMovieTicket:(NSDictionary *)params withType:(JDREModuleMovieTicketType)type
{
    //implemented by subclass
}

- (void)openPlayer:(NSDictionary *)params withType:(JDREModulePlayerType)type
{
    //implemented by subclass
}

- (void)openVIP:(NSDictionary *)params withType:(JDREModuleVIPType)type
{
    //implemented by subclass
}

- (void)openSearch:(NSDictionary *)params withType:(JDREModuleSearchType)type
{
    //implemented by subclass
}

- (void)openShare:(NSDictionary *)params withType:(JDREModuleShareType)type
{
    //implemented by subclass
}

- (void)openQiXiu:(NSDictionary *)params withType:(JDREModuleQiXiuType)type
{
    //implemented by subclass
}

- (void)openPaoPao:(NSDictionary *)params withType:(JDREModulePaoPaoType)type
{
    //implemented by subclass
}

- (void)openUGC:(NSDictionary *)params withType:(JDREModuleUGCType)type
{
    //implemented by subclass
}

- (void)openPPQ:(NSDictionary *)params withType:(JDREModulePPQType)type
{
    //implemented by subclass
}

- (void)openHome:(NSDictionary *)params withType:(JDREModuleHomeType)type
{
    //implemented by subclass
}

- (void)openReader:(NSDictionary *)params withType:(JDREModuleReaderType)type
{
    
}

- (void)openOffline:(NSDictionary *)params withType:(JDREModuleOfflineType)type
{
    //implemented by subclass
}

@end
