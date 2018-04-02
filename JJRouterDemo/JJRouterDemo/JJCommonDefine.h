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


#endif /* JJCommonDefine_h */
