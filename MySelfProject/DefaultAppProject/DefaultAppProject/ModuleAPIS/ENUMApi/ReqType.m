//
//  ReqType.m
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#import "ReqType.h"
#import "AExtendsHeaders.h"

@interface ReqType()

@property(assign,nonatomic)REQTYPE type;
@property(strong,nonatomic)NSDictionary<NSNumber*,NSString*>* dicData;

@end

@implementation ReqType

- (instancetype)initWithReqType:(REQTYPE)type{
    if (self = [super init]) {
        self.type = type;
        [self loadData];
    }
    return self;
}
- (void)loadData{
    self.dicData = @{
                     @(REQ_GET):@"GET",
                     @(REQ_POST):@"POST"
                     };
}
- (NSString*)fecthValue{
    return [self.dicData safe_value:@(self.type)];
}
- (REQTYPE)fecthKey{
    return self.type;
}
@end
