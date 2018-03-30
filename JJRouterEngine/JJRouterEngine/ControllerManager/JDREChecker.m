//
//  JDREChecker.m
//  JEREngine
//
//  Created by zhangyi35 on 2018/3/23.
//  Copyright © 2018年 zhangyi35. All rights reserved.
//

#import "JDREChecker.h"
#import "JDREApi.h"
#import "JDREControlCenter.h"

@implementation JDREChecker
- (BOOL)check:(JDREObject*)callObj
{
    NSArray *moduleArray = [[JDREControlCenter sharedInstance] moduleArray];
    
    return [moduleArray containsObject:[NSNumber numberWithInt:enumJDREModuleAll]] || [moduleArray containsObject:[NSNumber numberWithInt:callObj.module]];
}
@end
