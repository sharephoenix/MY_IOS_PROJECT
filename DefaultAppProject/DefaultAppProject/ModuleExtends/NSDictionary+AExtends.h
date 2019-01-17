//
//  NSDictionary+AExtends.h
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AExtends)

// 安全获取 值
- (id)safe_value:(id)key;
// JSON 转 字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
