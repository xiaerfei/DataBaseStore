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
    NSTimeInterval begin, end;
    
    begin = CACurrentMediaTime();
    TestTable *testTable = [[TestTable alloc] init];
    // 查询数据库有多少条数据
    NSNumber *count = [testTable countTotalRecord];
    NSLog(@"数据库有 %@ 条数据",count);
    end = CACurrentMediaTime();
    printf("查询数据库有多少条数据:         %8.8fms   \n", (end - begin)*1000);
    printf("\n");

    begin = CACurrentMediaTime();
    // 条件查询  26 到 30 之间有多少个人
    NSString *whereCondition = @":age >= :minAge AND :age <= :maxAge";
    NSNumber *minAge = @(26);
    NSNumber *maxAge = @(30);
    NSString *age    = @"age";
    NSDictionary *whereConditionParams = NSDictionaryOfVariableBindings(age,minAge,maxAge);
    NSNumber *fetchCount = [testTable countWithWhereCondition:whereCondition conditionParams:whereConditionParams];
    NSLog(@"查询  26 到 30 之间有 %@ 个人",fetchCount);
    end = CACurrentMediaTime();
    printf("查询  26 到 30 之间有多少个人:         %8.8fms   \n", (end - begin)*1000);
    printf("\n");
    
    begin = CACurrentMediaTime();
    // 条件查询  返回 26 到 30 之间的人
    NSArray *fetchDataList = [testTable fetchDataWithWhereCondition:whereCondition conditionParams:whereConditionParams isDistinct:NO isTransformItemsToClass:YES];
    end = CACurrentMediaTime();
    printf("返回 26 到 30 之间的人:         %8.8fms   \n", (end - begin)*1000);
    printf("\n");
    
    for (TestModel *model in fetchDataList) {
        NSLog(@"name = %@ age = %@ stuClass = %@ tomas = %@",model.name,model.age,model.stuClass,model.tomas);
    }
}

@end
