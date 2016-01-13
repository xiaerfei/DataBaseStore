//
//  RYDataBaseMarcos.h
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#ifndef DataBaseStore_RYDataBaseMarcos_h
#define DataBaseStore_RYDataBaseMarcos_h


#define isEmptyString(string) ((string == nil || string.length == 0) ? YES : NO)

#define DEBUGLOG

#ifdef DEBUGLOG
# define DELog(fmt, ...) NSLog((@"[函数名:%s]       " "[行号:%d] \n" fmt),__FUNCTION__, __LINE__, ##__VA_ARGS__);
# define DFLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DELog(...);
# define DFLog(...);
#endif



static NSInteger RYDataBaseNoLimit  = -1;
static NSInteger RYDataBaseNoOffset = -1;

#endif
