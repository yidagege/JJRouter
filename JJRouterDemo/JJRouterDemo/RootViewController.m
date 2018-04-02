//
//  RootViewController.m
//  Router
//
//  Created by 张毅 on 2018/3/26.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import "RootViewController.h"
#import "JJEApi.h"
#import "JJCommonDefine.h"

@interface RootViewController ()
@property (nonatomic, assign) NSInteger currentSelectedIndex;

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
    [super viewDidLoad];
    
    [self initFindVC];
    [self initMyVC];
    [self setTabBarController];
}

- (void)initFindVC {
    _findVC = [FindViewController new];
    _findVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"icon-fenlei-unselected"] selectedImage:[[UIImage imageNamed:@"icon-fenlei-unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [_findVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColorTextMain, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    _findNaviVC = [JJNavigationController withRootViewController:_findVC];
}

- (void)initMyVC {
    _myVC = [MyViewController new];

    _myVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tabbarIconMineNormal"] selectedImage:[[UIImage imageNamed:@"tabbarIconMineNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [_myVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColorTextMain, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    _myNaviVC = [JJNavigationController withRootViewController:_myVC];
}

- (void)setTabBarController {
    [self setViewControllers:@[_findNaviVC, _myNaviVC] animated:NO];
    [self.tabBar setTintColor:kColorTextMain];
    self.currentSelectedIndex = 0;
    [self setSelectedIndex:self.currentSelectedIndex];
}

@end
