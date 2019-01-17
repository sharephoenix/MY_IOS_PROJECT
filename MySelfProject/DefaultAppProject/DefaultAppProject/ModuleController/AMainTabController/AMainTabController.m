//
//  AMainTabController.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/10.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "AMainTabController.h"
#import "ABaseNavController.h"
#import "AHomeController.h"
#import "AMineController.h"

@interface AMainTabController ()

@end

@implementation AMainTabController
{
    AHomeController *homeController;
    AMineController *mineController;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    homeController = [AHomeController new];
    mineController = [AMineController new];
    ABaseNavController *homenav = [[ABaseNavController alloc] initWithRootViewController:homeController];
    ABaseNavController *minenav = [[ABaseNavController alloc] initWithRootViewController:mineController];


    UITabBarItem *homeitem = [[UITabBarItem alloc] initWithTitle:@"home" image:nil selectedImage:nil];
    homeitem.badgeValue = @"100";
    homenav.tabBarItem = homeitem;

    UITabBarItem *mineitem = [[UITabBarItem alloc] initWithTitle:@"mine" image:nil selectedImage:nil];
    minenav.tabBarItem = mineitem;

    self.viewControllers = @[homenav,minenav];
}


@end
