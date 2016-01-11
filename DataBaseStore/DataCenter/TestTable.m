//
//  TestTable.m
//  RYDataBaseStore
//
//  Created by xiaerfei on 15/11/8.
//  Copyright © 2015年 geren. All rights reserved.
//

#import "TestTable.h"
#import "TestModel.h"

@implementation TestTable


- (NSString *)databaseName
{
    return @"test.db";
}

- (NSString *)tableName
{
    return @"test";
}
- (NSDictionary *)columnInfo
{
    return @{
            @"primaryKey":@"INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL",
            @"name":@"TEXT",
            @"age":@"INTEGER",
            @"stuClass":@"INTEGER",
            @"tomas":@"TEXT NOT NULL"
            };
}

- (NSString *)primaryKeyName
{
    return @"primaryKey";
}
- (Class)recordClass
{
    return [TestModel class];
}

@end
