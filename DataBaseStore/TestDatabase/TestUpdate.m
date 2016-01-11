//
//  TestUpdate.m
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "TestUpdate.h"
#import "TestTable.h"
#import "TestModel.h"



@implementation TestUpdate

- (void)test
{
    TestTable *testTable = [[TestTable alloc] init];
    
    [testTable updateKeyValueList:@{@"name" :@"xiaoming"} whereConditionParam:@{@"age":@(27),@"class":@(3)}];
    
    
    TestModel *testModel = [[TestModel alloc] init];
    testModel.name = @"小赵";
    testModel.age  = @(30);
    testModel.stuClass = @(8);
    testModel.tomas = @"是个老男孩！so bad";
    
    [testTable updateDataClass:testModel whereConditionParam:@{@"age":@(30)} shouldOverride:NO];

    
    NSString *whereCondition = @":age >= :minAge AND :age <= :maxAge";
    NSNumber *minAge = @(28);
    NSNumber *maxAge = @(30);
    NSString *age    = @"age";
    NSDictionary *whereConditionParams = NSDictionaryOfVariableBindings(age,minAge,maxAge);
    [testTable updateKeyValueList:@{@"tomas":@"study hard !"} whereCondition:whereCondition conditionParam:whereConditionParams];
    

}

@end
