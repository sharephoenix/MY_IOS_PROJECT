//
//  AutoCreateController.h
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/10.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoCreateController : NSObject

+ (UIViewController*)create:(NSString *)action_name params:(NSDictionary *)params;

@end
