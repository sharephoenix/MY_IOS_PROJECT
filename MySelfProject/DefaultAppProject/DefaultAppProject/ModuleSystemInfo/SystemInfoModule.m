//
//  SystemInfoModule.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "SystemInfoModule.h"

@interface SystemInfoModule()

@property(copy,nonatomic)NSString* appname;     // app 名称
@property(copy,nonatomic)NSString* appversion;  // app 的版本号
@property(copy,nonatomic)NSString* appversion_build;  // app 的版本号

@end

@implementation SystemInfoModule
+(SystemInfoModule*)instance{
    static dispatch_once_t onceToken;
    static SystemInfoModule *systeminfo =nil;
    dispatch_once(&onceToken, ^{
        systeminfo = [SystemInfoModule new];
        [systeminfo resetSystemInfo];
    });
    return systeminfo;
}
- (NSString *)getAppName{
    return self.appname;
}
- (NSString *)getAppVersion{
    return self.appversion;
}
- (NSString *)getAppVersionBuild{
    return self.appversion_build;
}
#pragma mark - 初始化系统信息
- (void)resetSystemInfo{
    NSDictionary * dic = [[NSBundle mainBundle] infoDictionary];
    _appname = dic[@"CFBundleDisplayName"];
    _appversion = dic[@"CFBundleShortVersionString"];
    _appversion_build = dic[@"CFBundleVersion"];

}

@end
