//
//  AsynAndThreadTest.m
//  ObjcDemo
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AsynAndThreadTest.h"

@implementation AsynAndThreadTest

/**
 多运行几次，会出现线程复用的情况。异步通过线程池解决: 任务调度 线程通信 线程服用 线程创建 等问题
 */
+(void)testThreadAndAsyn{
    dispatch_queue_t queue = dispatch_queue_create("gcdtest.rongfzh.yc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"asyncThread:%@",[NSThread currentThread]);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            [NSThread sleepForTimeInterval:1];
            
            NSLog(@"group1:%@",[NSThread currentThread]);
        });
        dispatch_group_async(group, queue, ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"group2:%@",[NSThread currentThread]);
        });
        dispatch_group_async(group, queue, ^{
            [NSThread sleepForTimeInterval:3];
            NSLog(@"group3:%@",[NSThread currentThread]);
        });
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSLog(@"updateUi:%@",[NSThread currentThread]);
        });
    });
}

@end
