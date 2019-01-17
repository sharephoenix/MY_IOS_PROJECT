//
//  ACacheGap.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "ACacheGap.h"

@interface ACacheGap()

@end

@implementation ACacheGap
+ (ACacheGap*)instance{
    static dispatch_once_t onceToken;
    static ACacheGap* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [ACacheGap new];
        [instance resetApplictioninfo];
    });
    return instance;
}

// 初始化，启动app 数据，将 部分数据写入缓存中
- (void)resetApplictioninfo{

}
- (BOOL)islogin{
    BOOL flag = NO;

    return flag;
}
@end
