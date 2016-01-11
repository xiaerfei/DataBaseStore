//
//  ViewController.m
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/10.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "ViewController.h"
#import "TestInsert.h"
#import "TestUpdate.h"
#import "TestFetch.h"
#import "TestDelete.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // 测试 插入数据
//    TestInsert *testInsert = [[TestInsert alloc] init];
//    [testInsert test];
//    //测试 更新数据
//    TestUpdate *testUpdate = [[TestUpdate alloc] init];
//    [testUpdate test];
//    //测试 查询数据
//    TestFetch *testFetch = [[TestFetch alloc] init];
//    [testFetch test];
    // 删除数据
    TestDelete *testDelete = [[TestDelete alloc] init];
    [testDelete test];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
