//
//  BaseViewController.m
//  Router
//
//  Created by 张毅 on 2018/3/26.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];;
}


- (void)showInParentController:(UIViewController *)controller
{
    if (![controller isKindOfClass:[UIViewController class]]) {
        return;
    }
    
    if (controller != JJDelegate.rootVc ) {
        [controller.navigationController pushViewController:self animated:YES];
    }else if (controller == JJDelegate.rootVc){
        [JJDelegate.rootVc.currentVC.navigationController pushViewController:self animated:YES];
    }
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    if (_closeBlock) {
        _closeBlock();
    }
}

@end
