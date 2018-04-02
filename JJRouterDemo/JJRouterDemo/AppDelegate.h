//
//  AppDelegate.h
//  JJRouterDemo
//
//  Created by 张毅 on 2018/3/31.
//  Copyright © 2018年 zhangyi. All rights reserved.
//
#import "RootViewController.h"
#import <UIKit/UIKit.h>
#define JJDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) RootViewController* rootVc;


@end

