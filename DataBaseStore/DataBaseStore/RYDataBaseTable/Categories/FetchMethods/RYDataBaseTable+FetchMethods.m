//
//  RYDataBaseTable+FetchMethods.m
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "RYDataBaseTable+FetchMethods.h"
#import "NSString+SQL.h"
#import "RYDataBaseMarcos.h"

@implementation RYDataBaseTable (FetchMethods)

- (NSString *)select:(NSString *)columList isDistinct:(BOOL)isDistinct
{
    NSString *sqlString = @"";
    if (columList == nil) {
        if (isDistinct) {
            sqlString = @"SELECT DISTINCT * ";
        } else {
            sqlString = @"SELECT * ";
        }
    } else {
        if (isDistinct) {
            sqlString = [NSString stringWithFormat:@"SELECT DISTINCT '%@' ", columList];
        } else {
            sqlString = [NSString stringWithFormat:@"SELECT '%@' ", columList];
        }
    }
    return sqlString;
}

- (NSString *)from:(NSString *)fromList
{
    NSString *sqlString = @"";
    if (fromList == nil) {
        return sqlString;
    }
    sqlString = [NSString stringWithFormat:@"FROM '%@' ",fromList];
    return sqlString;
}

- (NSString *)where:(NSString *)condition params:(NSDictionary *)params
{
    NSString *sqlString = @"";
    if (condition == nil) {
        return sqlString;
    }
    NSString *whereString = [condition stringWithSQLParams:params];
    sqlString = [NSString stringWithFormat:@"WHERE %@ ", whereString];
    return sqlString;
}

- (NSString *)orderBy:(NSString *)orderBy isDESC:(BOOL)isDESC
{
    NSString *sqlString = @"";
    if (orderBy == nil) {
        return sqlString;
    }
    sqlString = [NSString stringWithFormat:@"ORDER BY %@ ",orderBy];
    if (isDESC) {
        sqlString = [sqlString stringByAppendingString:@"DESC "];
    } else {
        sqlString = [sqlString stringByAppendingString:@"ASC "];
    }
    return sqlString;
}

- (NSString *)limit:(NSInteger)limit
{
    NSString *sqlString = @"";
    if (limit == RYDataBaseNoLimit) {
        return sqlString;
    }
    sqlString = [NSString stringWithFormat:@"LIMIT %lu ", (unsigned long)limit];
    return sqlString;
}

- (NSString *)offset:(NSInteger)offset
{
    NSString *sqlString = @"";
    if (offset == RYDataBaseNoOffset) {
        return sqlString;
    }
    sqlString = [NSString stringWithFormat:@"OFFSET %lu ", (unsigned long)offset];
    return sqlString;
}

- (NSString *)limit:(NSInteger)limit offset:(NSInteger)offset
{
    return [NSString stringWithFormat:@"%@%@",[self limit:limit],[self offset:offset]];
}
@end
