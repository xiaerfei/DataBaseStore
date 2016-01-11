//
//  RYDataBaseCriteria.m
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "RYDataBaseCriteria.h"
#import "RYDataBaseMarcos.h"
#import "RYDataBaseTable+FetchMethods.h"
#import "RYDataBaseTable.h"
#import "RYDataBaseTable+AnalyzeSQL.h"
@implementation RYDataBaseCriteria

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.limit = RYDataBaseNoLimit;
        self.offset = RYDataBaseNoOffset;
    }
    return self;
}

- (NSString *)applyToSelectDataBaseTable:(RYDataBaseTable *)dataBaseTable tableName:(NSString *)tableName
{
    NSMutableString *sqlString = [[NSMutableString alloc] init];
    [sqlString appendFormat:@"%@",[dataBaseTable select:self.select isDistinct:self.isDistinct]];
    [sqlString appendFormat:@"%@",[dataBaseTable from:tableName]];
    [sqlString appendFormat:@"%@",[dataBaseTable where:self.whereCondition params:self.whereConditionParams]];
    [sqlString appendFormat:@"%@",[dataBaseTable orderBy:self.orderBy isDESC:self.isDESC]];
    [sqlString appendFormat:@"%@;",[dataBaseTable limit:self.limit offset:self.offset]];
    return sqlString;
}

- (NSString *)applyToDeleteDataBaseTable:(RYDataBaseTable *)dataBaseTable tableName:(NSString *)tableName
{
    return [dataBaseTable analyzeOfDelete:tableName withCondition:self.whereCondition conditionParams:self.whereConditionParams];
}


@end
