//
//  NSString+AExtends.h
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AExtends)
// 字典转 JSON
+ (NSString *)dictToJsonStr:(NSDictionary *)dict;
// 判断 字符串 是否为空 包括 null nil ""
+ (BOOL)isnull:(NSString *)str;
@end
