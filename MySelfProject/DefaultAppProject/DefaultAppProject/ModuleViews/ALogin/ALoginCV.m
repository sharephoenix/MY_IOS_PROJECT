//
//  ALoginCV.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "ALoginCV.h"

@implementation ALoginCV

- (void)layoutSubviews{
    [super layoutSubviews];

}
- (IBAction)mobileLoginUIAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(toMobileLoginVC)]) {
        [self.delegate toMobileLoginVC];
    }
}
- (IBAction)qqLoginUIAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(toQQLoginVC)]) {
        [self.delegate toQQLoginVC];
    }
}
- (IBAction)wechatLoginAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(toWechatLoginVC)]) {
        [self.delegate toWechatLoginVC];
    }
}

@end
