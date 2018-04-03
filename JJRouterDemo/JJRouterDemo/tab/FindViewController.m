//
//  FindViewController.m
//  JJRouterDemo
//
//  Created by zhangyi35 on 2018/4/2.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import "FindViewController.h"
#import "JJEApi.h"

@interface FindViewController ()

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"find";
    UIButton *b1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    b1.backgroundColor = [UIColor redColor];
    [b1 addTarget:self action:@selector(goone) forControlEvents:UIControlEventTouchUpInside];
    [b1 setTitle:@"go 1" forState:UIControlStateNormal];
    [self.view addSubview:b1];
    UIButton *b2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 40)];
    b2.backgroundColor = [UIColor yellowColor];
    [b2 addTarget:self action:@selector(gotwo) forControlEvents:UIControlEventTouchUpInside];
    [b2 setTitle:@"go 2" forState:UIControlStateNormal];
    [self.view addSubview:b2];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)goone{
    NSDictionary *config = @{@"biz_id": @"100",
                             @"biz_plugin": @"",
                             @"biz_params": @{@"biz_sub_id": @"1",
                                              @"biz_params": @"",
                                              @"biz_dynamic_params": @"",
                                              @"biz_statistics": @""}};
    
    JJEModuleParameter *parameter = [[JJEModuleParameter alloc] init];
    parameter.originalParams = config;
    parameter.otherParams = @{kEngineKeyParentVC:self};
    parameter.closeCallBack = ^(JJECallbackData *callbackData) {
        
    };
    JJEOpenModule(parameter);
}

- (void)gotwo{
    NSDictionary *config = @{@"biz_id": @"100",
                             @"biz_plugin": @"",
                             @"biz_params": @{@"biz_sub_id": @"2",
                                              @"biz_params": @"",
                                              @"biz_dynamic_params": @"",
                                              @"biz_statistics": @""}};
    
    JJEModuleParameter *parameter = [[JJEModuleParameter alloc] init];
    parameter.originalParams = config;
    parameter.otherParams = @{kEngineKeyParentVC:self};
    parameter.closeCallBack = ^(JJECallbackData *callbackData) {
        
    };
    JJEOpenModule(parameter);
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
