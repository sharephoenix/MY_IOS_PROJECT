//
//  UIImage+AExtends.h
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AExtends)
// 从文件中获取图片
+ (UIImage *)imageFileNamed:(NSString *)name;
//MARK: 颜色转图片
+ (UIImage*)createImageWithstartColor:(UIColor *)startColor0 endColor:(UIColor *)endColor0;
+(UIImage*) wwCreateImageWithColor:(UIColor*) color;
@end
