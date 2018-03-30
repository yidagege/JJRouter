//
//  RootViewController.m
//  Router
//
//  Created by 张毅 on 2018/3/26.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import "RootViewController.h"
#import "JDREApi.h"

@interface RootViewController ()

@end

@implementation RootViewController


static RootViewController* sharedRootViewController = nil;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (id)sharedRootViewController
{
    @synchronized(self)
    {
        if (nil == sharedRootViewController)
        {
            sharedRootViewController = [[RootViewController alloc] init];
        }
        return sharedRootViewController;
    }
}

- (void)viewDidLoad{
    self.title = @"root";
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

- (void)goone{
    NSDictionary *config = @{@"biz_id": @"100",
                             @"biz_plugin": @"",
                             @"biz_params": @{@"biz_sub_id": @"1",
                                              @"biz_params": @"",
                                              @"biz_dynamic_params": @"",
                                              @"biz_statistics": @""}};

    JDREModuleParameter *parameter = [[JDREModuleParameter alloc] init];
    parameter.originalParams = config;
    parameter.otherParams = @{kEngineKeyParentVC:self};
    parameter.closeCallBack = ^(JDRECallbackData *callbackData) {
        
    };
    JDREOpenModule(parameter);
}

- (void)gotwo{
    NSDictionary *config = @{@"biz_id": @"100",
                             @"biz_plugin": @"",
                             @"biz_params": @{@"biz_sub_id": @"2",
                                              @"biz_params": @"",
                                              @"biz_dynamic_params": @"",
                                              @"biz_statistics": @""}};
    
    JDREModuleParameter *parameter = [[JDREModuleParameter alloc] init];
    parameter.originalParams = config;
    parameter.otherParams = @{kEngineKeyParentVC:self};
    parameter.closeCallBack = ^(JDRECallbackData *callbackData) {
        
    };
    JDREOpenModule(parameter);
}

@end
