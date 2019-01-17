//
//  NSString+AExtends.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "NSString+AExtends.h"

@implementation NSString (AExtends)

+ (BOOL)isnull:(NSString *)str{
    BOOL flag = NO;
    if (str == nil || [str isKindOfClass:[NSNull class]] || [str isEqual:[NSNull null]]) {
        flag = YES;
        goto TAILLabel;
    }
    if ([str isKindOfClass:[NSString class]]) {
        if ([str isEqualToString:@""]) {
            flag = YES;
            goto TAILLabel;
        }else{
            flag = NO;
            goto TAILLabel;
        }
    }else{
        flag = YES;
        goto TAILLabel;
    }
TAILLabel:
    return flag;

}
/**

 *  字段转换成json字符串

 *

 *  @param dict <#dict description#>

 *

 *  @return <#return value description#>

 */

+(NSString *)dictToJsonStr:(NSDictionary *)dict{

    //    NSMutableDictionary *dict = [NSMutableDictionary new];

    //    [dict setObject:@"" forKey:@"AWL_LAN"];

    //    [dict setObject:@"" forKey:@"AWL_LON"];

    //    [dict setObject:@"1"  forKey:@"U_ID"];

    NSString *jsonString = nil;

    if([NSJSONSerialization isValidJSONObject:dict])

    {

        NSError *error;

        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

        jsonString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

        //NSLog(@"json data:%@",jsonString);

        if(error) {

            NSLog(@"Error:%@",error);

        }

    }

    return jsonString;

}

@end
