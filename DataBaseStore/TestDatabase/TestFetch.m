//
//  TestFetch.m
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "TestFetch.h"
#import "TestTable.h"
#import "TestModel.h"


@implementation TestFetch

- (void)test
{
    TestTable *testTable = [[TestTable alloc] init];
    // 查询数据库有多少条数据
    NSNumber *count = [testTable countTotalRecord];
    NSLog(@"%@",count);
    // 条件查询  26 到 30 之间有多少个人
    NSString *whereCondition = @":age >= :minAge AND :age <= :maxAge";
    NSNumber *minAge = @(26);
    NSNumber *maxAge = @(30);
    NSString *age    = @"age";
    NSDictionary *whereConditionParams = NSDictionaryOfVariableBindings(age,minAge,maxAge);
    NSNumber *fetchCount = [testTable countWithWhereCondition:whereCondition conditionParams:whereConditionParams];
    NSLog(@"%@",fetchCount);
    
    // 条件查询  返回 26 到 30 之间的人
    NSArray *fetchDataList = [testTable fetchDataWithWhereCondition:whereCondition conditionParams:whereConditionParams isDistinct:NO isTransformItemsToClass:YES];
    for (TestModel *model in fetchDataList) {
        NSLog(@"name = %@ age = %@ stuClass = %@ tomas = %@",model.name,model.age,model.stuClass,model.tomas);
    }
}

@end
