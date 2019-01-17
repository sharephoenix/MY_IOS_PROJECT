//
//  UIImage+AExtends.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "UIImage+AExtends.h"
typedef enum : NSUInteger {
    pngImgEx,           // .png
    jpgImaEx,               // .jpg
    jpegImgEx,              // .jpeg
} ImageExtensionName;

@implementation UIImage (AExtends)
//MARK: 从文件中获取图片
+ (UIImage *)imageFileNamed:(NSString *)name{
    UIImage * currentImage = nil;
    NSString * filePath = [[NSBundle mainBundle] pathForResource:name ofType:[UIImage getExtName:pngImgEx]];

    if (filePath == nil) {
        NSString * fileName = [NSString stringWithFormat:@"%@%@",name,[UIImage getImageScaleStr]];
        filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:[UIImage getExtName:pngImgEx]];
    }

    currentImage = [UIImage imageWithContentsOfFile:filePath];

    return currentImage;
}

+ (NSString *)getExtName:(ImageExtensionName)exName {
    switch (exName) {
        case pngImgEx:
        {
            return @".png";
        }
            break;
        case jpgImaEx:{
            return @".jpg";
        }
            break;
        case jpegImgEx:{
            return @".jpeg";
        }
        default:
            return @".png";         // 默认 .png
            break;
    }
}

+ (NSString *)getImageScaleStr{     // 获取，图片的 分辨率 拼接 字符串
    return [NSString stringWithFormat:@"@%.0fx",[UIScreen mainScreen].scale];
}
//MARK: 颜色转图片
+ (UIImage*)createImageWithstartColor:(UIColor *)startColor0
                             endColor:(UIColor *)endColor0{

    CGRect rect=CGRectMake(0.0f,0.0f,2.0f,2.0f);
    CGRect pathRect = rect;

    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();

    //绘制Path
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMinY(rect));
    CGPathCloseSubpath(path);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 1, 1 };

    CGColorRef startColor = startColor0.CGColor;
    CGColorRef endColor = endColor0.CGColor;

    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];

    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    UIGraphicsBeginImageContext(rect.size);

    CGContextRef context = UIGraphicsGetCurrentContext();

    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));

    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);

    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);

    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return theImage;

}

+(UIImage*) wwCreateImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
