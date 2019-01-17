//
//  AMineController.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/10.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "AMineController.h"
#import "AMineProfileCV.h"

@interface AMineController ()

@end

@implementation AMineController
{
    AMineProfileCV *cv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"minecontroller";
    cv = [[[NSBundle mainBundle] loadNibNamed:@"AMineProfileCV" owner:nil options:nil] firstObject];
    [self.view addSubview:cv];

}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    cv.frame = self.view.bounds;
}

@end
