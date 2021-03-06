//
//  FirstViewController.m
//  Router
//
//  Created by 张毅 on 2018/3/28.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import "FirstViewController.h"
#import "JJEApi.h"

@interface FirstViewController ()

@end

@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"1";
    UIButton *b1 = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 100, 40)];
    self.view.backgroundColor = [UIColor greenColor];
    b1.backgroundColor = [UIColor yellowColor];
    [b1 addTarget:self action:@selector(goone) forControlEvents:UIControlEventTouchUpInside];
    [b1 setTitle:@"go 1" forState:UIControlStateNormal];
    [self.view addSubview:b1];
    
}

- (void)goone{
    NSDictionary *config = @{@"biz_id": @"100",
                             @"biz_plugin": @"",
                             @"biz_params": @{@"biz_sub_id": @"3",
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



@end
