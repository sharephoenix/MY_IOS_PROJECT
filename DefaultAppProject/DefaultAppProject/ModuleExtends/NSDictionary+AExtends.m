//
//  NSDictionary+AExtends.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "NSDictionary+AExtends.h"

@implementation NSDictionary (AExtends)
- (id)safe_value:(id)key{
    NSArray *allkeys = self.allKeys;
    BOOL flag = [allkeys containsObject:key];
    return flag?[self valueForKey:key]:nil;
}
/*!

 * @brief 把格式化的JSON格式的字符串转换成字典

 * @param jsonString JSON格式的字符串

 * @return 返回字典

 */

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {

    if(jsonString == nil) {

        return nil;

    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    NSError *err;

    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData

                                                        options:NSJSONReadingMutableContainers

                                                          error:&err];

    if(err) {

        NSLog(@"json解析失败：%@",err);

        return nil;

    }

    return dic;

}

@end
