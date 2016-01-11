//
//  TestDelete.m
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/26.
//  Copyright © 2015年 RongYu100. All rights reserved.
//

#import "TestDelete.h"
#import "TestTable.h"
#import "TestModel.h"

@implementation TestDelete

- (void)test{
    TestTable *testTable = [[TestTable alloc] init];
    
    NSString *whereCondition = @":age >= :minAge AND :age <= :maxAge";
    NSNumber *minAge = @(25);
    NSNumber *maxAge = @(30);
    NSString *age    = @"age";
    NSDictionary *whereConditionParams = NSDictionaryOfVariableBindings(age,minAge,maxAge);
    
    [testTable deleteWithWhereCondition:whereCondition conditionParams:whereConditionParams];
    
    TestModel *testModel = [[TestModel alloc] init];
    testModel.primaryKey = @(5);
    
    TestModel *testModel1 = [[TestModel alloc] init];
    testModel1.primaryKey = @(6);
    
    [testTable deleteDataClassList:@[testModel,testModel1]];

    [testTable deleteWithPrimaryKeyList:@[@(7),@(8)]];
    
    
    
    
    
}

@end
