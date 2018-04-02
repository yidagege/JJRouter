//
//  BaseViewController.m
//  Router
//
//  Created by 张毅 on 2018/3/26.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import "BaseViewController.h"
#define JJ_POP_ANIMATION_TIME       .4
#define getx(view)             view.frame.origin.x
#define gety(view)             view.frame.origin.y
#define getwidth(view)         view.frame.size.width
#define getheight(view)        view.frame.size.height

#define gx(view)                getx(view)//!获取view x坐标
#define gy(view)                gety(view)//!获取view y坐标
#define gw(view)                getwidth(view)//!获取view 宽度
#define gh(view)                getheight(view)//!获取view 高度
#define gs(view)                view.frame.size//!获取view size
#define go(view)                view.frame.origin//!获取view origin
#define gb(view)                (gety(view) + getheight(view))//!获取view的下边沿y坐标
#define gr(view)                (getx(view) + getwidth(view))//!获取view的右边沿x坐标
#define gcy(view)               view.center.y//获取VIew中心的Y
#define gcx(view)               view.center.x//获取VIew中心的x


#define ss(view,size)           set_size(view,size)//!设置view size
#define so(view,origin)         set_origin(view,origin)//!设置view origin
#define svs(view,scale)         set_view_scale_size(view,scale)//!缩放view宽高, scale分之一

#define sx(view,x)              set_x(view,x)//!设置view x
#define sy(view,y)              set_y(view,y)//!设置view y
#define sw(view,w)              set_width(view,w)//!设置view宽
#define sh(view,h)              set_height(view,h)//!设置view高
#define RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface BaseViewController ()
@property (nonatomic, weak) UIViewController *rootVC;

@end

@implementation BaseViewController

-(instancetype)init{
    if (self = [super init]) {
        if ([UIApplication sharedApplication].windows.count) {
            _rootVC = [[UIApplication sharedApplication].windows[0] rootViewController];
        }
    }
    return self;
}

- (void)showInParentController:(UIViewController *)controller
{
    if (![controller isKindOfClass:[UIViewController class]]) {
        return;
    }
    
    UIView *parentView = controller.view;
    UIImageView *imaView = nil;
    
    if (controller.navigationController) {
        UIGraphicsBeginImageContextWithOptions(parentView.bounds.size, NO, 0);
        [controller.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        imaView = [[UIImageView alloc] initWithImage:image];
        imaView.frame = parentView.bounds;
        [parentView addSubview:imaView];
        parentView = imaView;
    }
    
    [controller addChildViewController:self];
    
    if (controller != (UIViewController *)_rootVC && ![controller isKindOfClass:[NSClassFromString(@"JJControllerContainerViewController") class]]) {
        self.view.frame = self.view.bounds;
    }
    
    //view 消失
    if (controller && [controller respondsToSelector:@selector(JJCommonViewDisappear)])
    {
        [controller performSelector:@selector(JJCommonViewDisappear) withObject:nil];
    }
    
    UIView *maskView = [[UIView alloc] init];
    maskView.frame = CGRectMake(0, 0, gw(parentView) * 2, gh(parentView));
    maskView.backgroundColor = RGBACOLOR(0, 0, 0, .6);
    maskView.alpha = 0;
    [parentView addSubview:maskView];
    
    //为maskview添加手势，防止子view进入过程中，父view被滑动关闭
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:nil];
    [maskView addGestureRecognizer:pan];
    
    //防止侧滑进入时，事件漏到下一层
    UIView *holdView = [[UIView alloc] initWithFrame:parentView.bounds];
    if (controller.parentViewController) {
        [controller.parentViewController.view insertSubview:holdView belowSubview:parentView];
    }
    

    CGRect newFrame = CGRectOffset(self.view.frame, CGRectGetWidth(self.view.bounds), 0);
    newFrame.origin.y = 0.0f;
    
    self.view.frame = newFrame;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [parentView addSubview:self.view];
    
    __block BOOL translatesAutoresizingMaskIntoConstraints = parentView.translatesAutoresizingMaskIntoConstraints;
    parentView.translatesAutoresizingMaskIntoConstraints = YES;
    
    [UIView animateWithDuration:JJ_POP_ANIMATION_TIME delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.frame = CGRectOffset(self.view.frame, -CGRectGetWidth(self.view.bounds) + gw(parentView) / 4, 0);
        maskView.alpha = 1;
        parentView.center = CGPointMake(gcx(parentView) - gw(parentView) / 4, gcy(parentView));
    } completion:^(BOOL finished) {
        [holdView removeFromSuperview];
        [maskView removeFromSuperview];
        parentView.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints;
        parentView.center = CGPointMake(gcx(parentView) + gw(parentView) / 4, gcy(parentView));
        self.view.frame = CGRectOffset(self.view.frame, - gw(parentView) / 4, 0);
        
        if (imaView) {
            [controller.view addSubview:self.view];
            [imaView removeFromSuperview];
        }
    }];
    
    //view 显示
    if (self && [self respondsToSelector:@selector(JJCommonViewAppear)])
    {
        [self performSelector:@selector(JJCommonViewAppear) withObject:nil];
    }
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
}





@end
