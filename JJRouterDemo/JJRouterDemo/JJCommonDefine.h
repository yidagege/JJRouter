//
//  JJCommonDefine.h
//  JJRouterDemo
//
//  Created by zhangyi35 on 2018/4/2.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#ifndef JJCommonDefine_h
#define JJCommonDefine_h
#define kEngineKeyParentVC       @"parentVC"
#define kColorTextMain UIColorFromRGB(0x272726)

static inline UIColor *UIColorFromRGB(NSInteger rgb) {
    return [UIColor colorWithRed:(((rgb & 0xFF0000) >> 16) / 255.0) green:(((rgb & 0xFF00) >> 8) / 255.0) blue:((rgb & 0xFF) / 255.0) alpha:1.0];
}


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



#endif /* JJCommonDefine_h */
