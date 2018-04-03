//
//  BaseViewController.h
//  Router
//
//  Created by 张毅 on 2018/3/26.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CommonViewCloseBlock)(void);

@interface BaseViewController : UIViewController
@property (nonatomic, copy) CommonViewCloseBlock closeBlock;

- (void)showInParentController:(UIViewController *)controller;
- (void)back;

@end
