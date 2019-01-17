//
//  ACacheGap.h
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACacheGap : NSObject

+ (ACacheGap*)instance;
// 判断用户是否登录
- (BOOL)islogin;

@end
