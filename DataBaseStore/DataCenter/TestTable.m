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
    return @{COLUMN_INFO(TestModel, primaryKey):@"INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL",
             COLUMN_INFO(TestModel, name):@"TEXT",
             COLUMN_INFO(TestModel, age):@"INTEGER",
             COLUMN_INFO(TestModel, stuClass):@"INTEGER",
             COLUMN_INFO(TestModel, tomas):@"TEXT NOT NULL",};
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
