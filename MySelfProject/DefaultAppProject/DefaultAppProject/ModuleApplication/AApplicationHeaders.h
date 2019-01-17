//
//  AApplicationHeaders.h
//  DefaultAppProject
//
//  Created by Luan Alex on 2018/10/8.
//  Copyright © 2018年 Luan Alex. All rights reserved.
//

#ifndef AApplicationHeaders_h
#define AApplicationHeaders_h

#import "AExtendsHeaders.h"
#import "ACacheGap.h"
#import "SystemInfoModule.h"

#ifdef DEBUG
# define DLog(format, ...) NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d]" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...);
#endif

#endif /* AApplicationHeaders_h */
