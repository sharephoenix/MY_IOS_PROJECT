//
//  MobileLoginController.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/10.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "MobileLoginController.h"
#import "ALoginMobileCV.h"

@interface MobileLoginController ()

@end

@implementation MobileLoginController
{
    ALoginMobileCV *cv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    cv = [[[NSBundle mainBundle] loadNibNamed:@"ALoginMobileCV" owner:nil options:nil] firstObject];
    [self.view addSubview:cv];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    cv.frame = self.view.bounds;
}

@end
