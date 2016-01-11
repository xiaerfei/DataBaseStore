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
    
    NSTimeInterval begin, end;
    
    begin = CACurrentMediaTime();
    TestTable *testTable = [[TestTable alloc] init];
    NSString *whereCondition = @":age >= :minAge AND :age <= :maxAge";
    NSNumber *minAge = @(20);
    NSNumber *maxAge = @(30);
    NSString *age    = @"age";
    NSDictionary *whereConditionParams = NSDictionaryOfVariableBindings(age,minAge,maxAge);
    
    [testTable deleteWithWhereCondition:whereCondition conditionParams:whereConditionParams];
    end = CACurrentMediaTime();
    printf("删除 20--30岁之间的人:         %8.8fms   \n", (end - begin)*1000);
    printf("\n");
}

@end
