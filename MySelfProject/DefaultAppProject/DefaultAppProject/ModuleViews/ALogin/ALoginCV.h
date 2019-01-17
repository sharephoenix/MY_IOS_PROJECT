//
//  ALoginCV.h
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "ABaseView.h"

@protocol ALoginCVProtocol<NSObject>

- (void)toMobileLoginVC;
- (void)toQQLoginVC;
- (void)toWechatLoginVC;

@end

@interface ALoginCV : ABaseView

@property(weak,nonatomic)id<ALoginCVProtocol> delegate;

@end
