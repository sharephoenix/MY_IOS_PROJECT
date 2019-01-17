//
//  NSArray+AExtends.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "NSArray+AExtends.h"

@implementation NSArray (AExtends)
- (id)safe_value:(NSUInteger)index{
    NSUInteger count = self.count;
    id value = nil;
    if (index<count) {
        value = [self objectAtIndex:index];
    }
    return value;
}
@end
