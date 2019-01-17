//
//  ReqType.h
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    REQ_GET,
    REQ_POST
} REQTYPE;

@interface ReqType : NSObject
// 初始化枚举类
- (instancetype)initWithReqType:(REQTYPE)type;
// 获取 原始值
- (NSString*)fecthValue;
// 根据值，获取key
- (REQTYPE)fecthKey;

@end
