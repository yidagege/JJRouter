//
//  JJNavigationController.m
//  JJRouterDemo
//
//  Created by zhangyi35 on 2018/4/2.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import "JJNavigationController.h"
#import "JJNavigationBar.h"

@interface JJNavigationController ()

@end

@implementation JJNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [self initWithNavigationBarClass:[JJNavigationBar class] toolbarClass:nil];
    if (self && rootViewController) {
        self.viewControllers = @[rootViewController];
    }
    return self;
}

+ (instancetype)withRootViewController:(UIViewController *)rootViewController {
    return [[self alloc] initWithRootViewController:rootViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
