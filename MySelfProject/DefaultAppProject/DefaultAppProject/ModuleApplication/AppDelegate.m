//
//  AppDelegate.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "AppDelegate.h"
#import "AApplicationHeaders.h"

#import "ABaseNavController.h"
#import "ApplicationController.h"
#import "MainLoginController.h"
#import "AMainTabController.h"
#import "AutoCreateController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    ApplicationController *appController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    appController = [ApplicationController new];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = appController;
    [self.window makeKeyAndVisible];

    [SystemInfoModule instance];
    BOOL user_islogin = [[ACacheGap instance] islogin];


    if (user_islogin) {
        DLog(@"用户已经登录");
        UIViewController *tab = [AutoCreateController create:@"AMainTabController" params:nil];
        [appController presentViewController:tab animated:NO completion:nil];
    }else{
        DLog(@"用户还没有登录");
        UIViewController *mainLoginVC = [AutoCreateController create:@"MainLoginController" params:nil];
        ABaseNavController *nav = [[ABaseNavController alloc] initWithRootViewController:mainLoginVC];
        [appController presentViewController:nav animated:NO completion:nil];
    }


    NSLog(@"");
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
