//
//  RYDataBaseTable+AnalyzeSQL.m
//  RYDataBaseStore
//
//  Created by xiaerfei on 15/11/8.
//  Copyright © 2015年 geren. All rights reserved.
//

#import "RYDataBaseTable+AnalyzeSQL.h"
#import "objc/runtime.h"
#import "RYDataBaseMarcos.h"
#import "RYDataBaseTable+FetchMethods.h"
#import "NSString+SQL.h"

@implementation RYDataBaseTable (AnalyzeSQL)

- (NSString *)analyzeOfCreateTableWithTabelName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo
{
    
    NSMutableString *sql = [[NSMutableString alloc] init];
    
    NSMutableArray *columnList = [[NSMutableArray alloc] init];
    [columnInfo enumerateKeysAndObjectsUsingBlock:^(NSString *  columnName, NSString *  columnDescription, BOOL *  stop) {
        NSString *safeColumnName = columnName;
        NSString *safeDescription = columnDescription;
        
        if (isEmptyString(safeDescription)) {
            [columnList addObject:[NSString stringWithFormat:@"`%@`", safeColumnName]];
        } else {
            [columnList addObject:[NSString stringWithFormat:@"`%@` %@", safeColumnName, safeDescription]];
        }
    }];
    
    NSString *columns = [columnList componentsJoinedByString:@","];
    if ([self.child respondsToSelector:@selector(unique)]) {
        [sql appendFormat:@"CREATE TABLE IF NOT EXISTS `%@` (%@,%@);", tableName, columns,[self.child unique]];
    } else {
        [sql appendFormat:@"CREATE TABLE IF NOT EXISTS `%@` (%@);", tableName, columns];
    }
    return sql;
}

- (NSString *)analyzeOfUpdateTableWithTabelName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo primary:(NSDictionary *)primary;
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    NSMutableArray *valueList = [[NSMutableArray alloc] init];
    [columnInfo enumerateKeysAndObjectsUsingBlock:^(id   key, id   obj, BOOL *  stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [valueList addObject:[NSString stringWithFormat:@"`%@`='%@'", key,obj]];
        } else if ([obj isKindOfClass:[NSNull class]]) {
            [valueList addObject:[NSString stringWithFormat:@"`%@`=NULL", key]];
        } else {
            [valueList addObject:[NSString stringWithFormat:@"`%@`=%@", key, obj]];
        }
    }];
    if (primary != nil) {
        NSMutableArray *primaryArray = [[NSMutableArray alloc] init];
        [primary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *priStr = nil;
            if ([obj isKindOfClass:[NSString class]]) {
                priStr = [NSString stringWithFormat:@"%@=`%@`",key,obj];
            } else {
                priStr = [NSString stringWithFormat:@"%@=%@",key,obj];
            }
            [primaryArray addObject:priStr];
        }];
        NSString *primaryString = [NSString stringWithFormat:@"WHERE %@",[primaryArray componentsJoinedByString:@" AND "]];
        
        
        NSString *columns = [NSString stringWithFormat:@"%@ %@",[valueList componentsJoinedByString:@","],primaryString];
        [sql appendFormat:@"UPDATE `%@` SET %@;", tableName, columns];
    } else {
        [sql appendFormat:@"UPDATE `%@` SET %@", tableName, [valueList componentsJoinedByString:@","]];
    }

    return sql;
}

- (NSString *)analyzeOfSelectTableWithTabelName:(NSString *)tableName primary:(NSDictionary *)primary
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    NSMutableArray *primaryArray = [[NSMutableArray alloc] init];
    [primary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *priStr = nil;
        if ([obj isKindOfClass:[NSString class]]) {
            priStr = [NSString stringWithFormat:@"%@=`%@`",key,obj];
        } else {
            priStr = [NSString stringWithFormat:@"%@=%@",key,obj];
        }
        [primaryArray addObject:priStr];
    }];
    
    [sql appendFormat:@"SELECT * FROM `%@` WHERE %@;", tableName, [primaryArray componentsJoinedByString:@" AND "]];
    return sql;
}


- (NSString *)analyzeOfInsertTableWithTabelName:(NSString *)tableName dataList:(NSArray *)dataList;
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    NSMutableArray *valueItemList = [[NSMutableArray alloc] init];
    __block NSString *columString = nil;
    [dataList enumerateObjectsUsingBlock:^(NSDictionary *  description, NSUInteger idx, BOOL *  stop) {
        NSMutableArray *columList = [[NSMutableArray alloc] init];
        NSMutableArray *valueList = [[NSMutableArray alloc] init];
        
        [description enumerateKeysAndObjectsUsingBlock:^(NSString *  colum, NSString *  value, BOOL *  stop) {
        
            [columList addObject:[NSString stringWithFormat:@"`%@`", colum]];
            if ([value isKindOfClass:[NSString class]]) {
                [valueList addObject:[NSString stringWithFormat:@"'%@'", [value safeSQLMetaString]]];
            } else if ([value isKindOfClass:[NSNull class]]) {
                [valueList addObject:@"NULL"];
            } else {
                [valueList addObject:[NSString stringWithFormat:@"'%@'", value]];
            }
        }];
        
        if (columString == nil) {
            columString = [columList componentsJoinedByString:@","];
        }
        NSString *valueString = [valueList componentsJoinedByString:@","];
        
        [valueItemList addObject:[NSString stringWithFormat:@"(%@)", valueString]];
    }];
    
    [sql appendFormat:@"INSERT INTO `%@` (%@) VALUES %@;", tableName, columString, [valueItemList componentsJoinedByString:@","]];
    return sql;
}

- (NSString *)analyzeOfReplaceTableWithTabelName:(NSString *)tableName dataList:(NSArray *)dataList;
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    NSMutableArray *valueItemList = [[NSMutableArray alloc] init];
    __block NSString *columString = nil;
    [dataList enumerateObjectsUsingBlock:^(NSDictionary *  description, NSUInteger idx, BOOL *  stop) {
        NSMutableArray *columList = [[NSMutableArray alloc] init];
        NSMutableArray *valueList = [[NSMutableArray alloc] init];
        
        [description enumerateKeysAndObjectsUsingBlock:^(NSString *  colum, NSString *  value, BOOL *  stop) {
            [columList addObject:[NSString stringWithFormat:@"`%@`", colum]];
            if ([value isKindOfClass:[NSString class]]) {
                [valueList addObject:[NSString stringWithFormat:@"'%@'", [value safeSQLMetaString]]];
            } else if ([value isKindOfClass:[NSNull class]]) {
                [valueList addObject:@"NULL"];
            } else {
                [valueList addObject:[NSString stringWithFormat:@"'%@'", value]];
            }
        }];
        
        if (columString == nil) {
            columString = [columList componentsJoinedByString:@","];
        }
        NSString *valueString = [valueList componentsJoinedByString:@","];
        
        [valueItemList addObject:[NSString stringWithFormat:@"(%@)", valueString]];
    }];
    
    [sql appendFormat:@"REPLACE INTO `%@` (%@) VALUES %@;", tableName, columString, [valueItemList componentsJoinedByString:@","]];
    return sql;
}

- (NSString *)analyzeOfDelete:(NSString *)tableName withCondition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams
{
    if (isEmptyString(tableName) || isEmptyString(condition)) {
        return @"";
    }
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM `%@` %@;", tableName,[self where:condition params:conditionParams]];
    return sql;
}




@end
