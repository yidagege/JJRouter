//
//  JDRETask.h
//  JEREngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JDREObject;
@class JDRECallback;

@interface JDRETask : NSObject

@property (nonatomic, strong) JDREObject *engineObj;
@property (nonatomic, strong) JDRECallback *engineCallback;

@end
