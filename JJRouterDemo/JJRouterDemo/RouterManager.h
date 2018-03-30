//
//  RouterManager.h
//  Router
//
//  Created by 张毅 on 2018/3/28.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import <Foundation/Foundation.h>


static inline /*__attribute__((always_inline))*/ NSString* toString(id x)
{
    if ([x isKindOfClass:[NSString class]]) return x;
    else if (!x || [x isKindOfClass:[NSNull class]]) return @"";
    else if ([x isKindOfClass:[NSNumber class]]) return [NSString stringWithFormat:@"%@",x];
    return [x description];
}
@interface RouterManager : NSObject

@end
