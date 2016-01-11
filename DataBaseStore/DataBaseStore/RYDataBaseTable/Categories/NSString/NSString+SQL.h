//
//  NSString+SQL.h
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/24.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SQL)

- (NSString *)stringWithSQLParams:(NSDictionary *)params;

- (NSString *)safeSQLMetaString;
@end
