//
//  RouterManager.m
//  Router
//
//  Created by 张毅 on 2018/3/28.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import "RouterManager.h"
#import "JDREApi.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation RouterManager

+ (void)load{
    [JDREApi registerByModuleID:@"100" andClassName:NSStringFromClass([self class])];
}

+ (void)launchWithParam:(JDREModuleParameter *)param {
    
    id biz_params = [param.originalParams objectForKey:@"biz_params"];
    if (!biz_params || ![biz_params isKindOfClass:[NSDictionary class]]) {
        JDRECallbackData *cbData = [JDRECallbackData callbackDataWithError:[NSError errorWithDomain:@"RouterManager" code:-1 userInfo:@{@"info":@"biz_params error"}] andData:nil];
        param.closeCallBack(cbData);
        return;
    }
    NSDictionary *infoDic = (NSDictionary *)biz_params;
    NSString *subID = toString([infoDic objectForKey:@"biz_sub_id"]);
    if (!subID || subID.length < 1) {
        JDRECallbackData *cbData = [JDRECallbackData callbackDataWithError:[NSError errorWithDomain:@"RouterManager" code:-1 userInfo:@{@"info":@"biz_sub_id error"}] andData:nil];
        param.closeCallBack(cbData);
        return;
    }
    
    if ([subID isEqualToString:@"1"]) {
        FirstViewController *v1 = [[FirstViewController alloc] init];
        v1.closeBlock = ^{
            JDRECallbackData *cb = [JDRECallbackData callbackDataWithError:nil andData:@{@"info":@"AddressViewController has dismissed"}];
            param.closeCallBack(cb);
        };
        [v1 showInParentController:param.otherParams[kEngineKeyParentVC]];
    }
    if ([subID isEqualToString:@"2"]) {
        SecondViewController *v2 = [[SecondViewController alloc] init];
        v2.closeBlock = ^{
            JDRECallbackData *cb = [JDRECallbackData callbackDataWithError:nil andData:@{@"info":@"AddressViewController has dismissed"}];
            param.closeCallBack(cb);
        };
        [v2 showInParentController:param.otherParams[kEngineKeyParentVC]];
    }

}



@end
