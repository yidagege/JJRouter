//
//  RootViewController.h
//  Router
//
//  Created by 张毅 on 2018/3/26.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"
#import "FindViewController.h"
#import "JJNavigationController.h"

@interface RootViewController : UITabBarController

@property (nonatomic, strong, readonly) MyViewController *myVC;
@property (nonatomic, strong, readonly) JJNavigationController *myNaviVC;

@property (nonatomic, strong, readonly) FindViewController *findVC;
@property (nonatomic, strong, readonly) JJNavigationController *findNaviVC;


+ (id)sharedRootViewController;

@end
