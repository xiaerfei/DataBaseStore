//
//  TestInsert.m
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "TestInsert.h"
#import "TestTable.h"
#import "TestModel.h"


@implementation TestInsert

- (void)test
{
    
    TestTable *testTable = [[TestTable alloc] init];
    NSTimeInterval begin, end;
    begin = CACurrentMediaTime();
    
    [testTable insertDataList:@[@{@"name" :@"大哥",
                                  @"age"  :@(22),
                               @"stuClass":@(3),
                                  @"tomas":@"lol 上单 擅长鳄鱼 目前退役"}]];
    end = CACurrentMediaTime();
    printf("insertDataList:         %8.8fms   \n", (end - begin)*1000);
    

    
    begin = CACurrentMediaTime();
    NSMutableArray *classArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 500; i++) {
        TestModel *testModel = [[TestModel alloc] init];
        testModel.name = @"小狗";
        testModel.age  = @(18);
        testModel.stuClass = @(i);
        testModel.tomas = @"lol 国内最强ADC，擅长vn 男枪 目前在OMG";
        
//        TestModel *testModel1 = [[TestModel alloc] init];
//        testModel1.name = @"Pawn";
//        testModel1.age  = @(18);
//        testModel1.stuClass = @(5);
//        testModel1.tomas = @"lol 世界最强中单，打败faker的man 目前在EDG";
//        
//        TestModel *testModel2 = [[TestModel alloc] init];
//        testModel2.name = @"厂长";
//        testModel2.age  = @(20);
//        testModel2.stuClass = @(1);
//        testModel2.tomas = @"lol 国内最强的打野 目前在EDG";
//        
//        TestModel *testModel3 = [[TestModel alloc] init];
//        testModel3.name = @"小仓";
//        testModel3.age  = @(30);
//        testModel3.stuClass = @(10);
//        testModel3.tomas = @"lol 国内美女解说  目前在做 小仓坑爹集锦、小仓暴走等等，已经退役解说，单身 据说和大哥...";
//        
//        TestModel *testModel4 = [[TestModel alloc] init];
//        testModel4.name = @"小妍";
//        testModel4.age  = @(28);
//        testModel4.stuClass = @(10);
//        testModel4.tomas = @"lol 国内美女解说 主要国内LPL解说，世界总决赛解说，zital（正在 IG 打上单） 女友";
//        
//        TestModel *testModel5 = [[TestModel alloc] init];
//        testModel5.name = @"小楼";
//        testModel5.age  = @(28);
//        testModel5.stuClass = @(10);
//        testModel5.tomas = @"lol 国内美女解说 主要国内LPL解说，世界总决赛解说，已经不经常出现了";
        [classArray addObject:testModel];
        
    }
    [testTable insertDataClassList:classArray];
    end = CACurrentMediaTime();
    printf("insertDataClassList:         %8.8fms   \n", (end - begin)*1000);

    
    TestModel *testModelMerge1 = [[TestModel alloc] init];
    testModelMerge1.age  = @(28);
    testModelMerge1.stuClass = @(10);
    
    TestModel *testModelMerge2 = [[TestModel alloc] init];
    testModelMerge2.name = @"merge";
    testModelMerge2.tomas = @"merge 数据";
    
    TestModel *mergeDataModel = [testModelMerge1 mergeRecord:testModelMerge2 shouldOverride:NO];
    
    NSLog(@"name = %@ age = %@ stuClass = %@ tomas = %@",mergeDataModel.name,mergeDataModel.age,mergeDataModel.stuClass,mergeDataModel.tomas);

    
    
}

@end
