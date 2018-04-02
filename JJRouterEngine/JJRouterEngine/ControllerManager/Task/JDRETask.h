//
//  JJETask.h
//  JEREngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JJEObject;
@class JJECallback;

@interface JJETask : NSObject

@property (nonatomic, strong) JJEObject *engineObj;
@property (nonatomic, strong) JJECallback *engineCallback;

@end
