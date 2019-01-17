//
//  BaseAPI.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "BaseAPI.h"
#import "ReqType.h"
#import "AApplicationHeaders.h"

#define REQ_TIME_OUT 15           // 网络请求的超时时间

@interface BaseAPI()

@property(strong,nonatomic)NSDictionary *reqHeaders;

@end

@implementation BaseAPI

+ (BaseAPI*)shareInstance{
    static dispatch_once_t onceToken;
    static BaseAPI *api = nil;
    dispatch_once(&onceToken, ^{
        api = [BaseAPI new];
    });
    return api;
}
- (NSDictionary*)reqHeaders{
    if (!_reqHeaders) {
        _reqHeaders = @{
//                        @"Content-Type":@"application/json",
                        @"Content-Type":@"application/octet-stream",//固定值 application/octet-stream
                        @"Accept":@"application/octet-stream",//固定值 application/octet-stream
                        };
    }
    return _reqHeaders;
}

- (void)req:(ReqType*)reqtype
 baseUrlStr:(NSString*)baseurl
 bodyUrlStr:(NSString*)urltailstr
     params:(NSDictionary*)param{
    // 获取请求类型
    NSString *req_type = [reqtype fecthValue];
    if (reqtype == nil) {
        DLog(@"发生异常停止继续执行 reutrn");
        return;
    }
    // 请求头部
    NSDictionary *httpheader = self.reqHeaders;
    // 请求 参数
    NSString *reqparam_str = [NSString dictToJsonStr:param];
    NSData *reqparam = reqparam_str==nil?[NSData data]:[reqparam_str dataUsingEncoding:NSUTF8StringEncoding];
    // 请求的 url 地址
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",baseurl,urltailstr];
    NSURL *url = [NSURL URLWithString:urlstr];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQ_TIME_OUT];
    [request setHTTPMethod:req_type];

    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setAllHTTPHeaderFields:httpheader];

    [request setHTTPBody:reqparam];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask* sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 获取请求数据
        DLog(@"%@",data);
    }];
    [sessionDataTask resume];
}










@end
