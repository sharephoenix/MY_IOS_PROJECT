//
//  SystemInfoModule.h
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemInfoModule : NSObject

+(SystemInfoModule*)instance;
// 获取 app 名称
- (NSString *)getAppName;
// 获取系统版本号
- (NSString *)getAppVersion;
- (NSString *)getAppVersionBuild;

@end
