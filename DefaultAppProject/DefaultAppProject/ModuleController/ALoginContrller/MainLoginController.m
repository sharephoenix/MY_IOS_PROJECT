//
//  MainLoginController.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "MainLoginController.h"
#import "ALoginCV.h"

@interface MainLoginController ()

@property(strong,nonatomic)ALoginCV *logincv;

@end

@implementation MainLoginController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.logincv];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.logincv.frame = self.view.bounds;
}
#pragma mark -getter/setter
- (ALoginCV*)logincv{
    if (!_logincv) {
        _logincv = [[[NSBundle mainBundle] loadNibNamed:@"ALoginCV" owner:nil options:nil] firstObject];
    }
    return _logincv;
}

@end
