//
//  AutoCreateController.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/10.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "AutoCreateController.h"

@implementation AutoCreateController

+ (UIViewController*)create:(NSString *)action_name params:(NSDictionary *)params{
    UIViewController *vc = nil;
    if ([NSString isnull:action_name]) {
        return vc;
    }
    NSDictionary *dic = [AutoCreateController controllerConfig];
    if (![dic.allKeys containsObject:action_name]) {
        return vc;
    }

    NSDictionary *config = [dic safe_value:action_name];
    NSString *classname = [config safe_value:@"classname"];
    Class class = NSClassFromString(classname);
    vc = [class new];
// 取交集，赋值相关的参数
    if (params != nil && [params isKindOfClass:[NSDictionary class]]) {
        NSDictionary *paramsdefault = [config safe_value:@"params"];

        NSMutableSet *paramsdefaultset = [NSMutableSet setWithArray:paramsdefault.allKeys];
        NSMutableSet *paramsset = [NSMutableSet setWithArray:params.allKeys];

        [paramsset intersectSet:paramsdefaultset];
        if (paramsset.count>0) {

            [paramsset enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
                [vc setValue:params[obj] forKey:obj];
            }];
            vc.title = [paramsdefault safe_value:@"title"];
        }else{
            goto CreateTail;
        }
    }

CreateTail:
    return vc;
}
+ (NSDictionary *)controllerConfig{
    NSString *filepath =  [[NSBundle mainBundle] pathForResource:@"controller" ofType:@"json" inDirectory:nil forLocalization:nil];

    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"controller" ofType:@"json"]];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    return dic;
}
@end
