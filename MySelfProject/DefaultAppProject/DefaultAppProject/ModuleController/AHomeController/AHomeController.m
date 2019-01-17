//
//  AHomeController.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/10.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "AHomeController.h"
#import "AHomeCV.h"

@interface AHomeController ()

@property (copy,nonatomic)NSString *str0;
@property (copy,nonatomic)NSString *str1;
@property (copy,nonatomic)NSString *str2;

@end

@implementation AHomeController
{
    AHomeCV *cv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"homecontroller";
    cv = [[[NSBundle mainBundle] loadNibNamed:@"AHomeCV" owner:nil options:nil] firstObject];
    [self.view addSubview:cv];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    cv.frame = self.view.bounds;
}
@end
