//
//  ADJSON.h
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "ABaseView.h"

@interface ADJSON : ABaseView
// 将字典或者数组转化为JSON串
+ (NSData *)toJSONData:(id)theData;
// 将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSData *)jsonData;

@end
