//
//  TestModel.h
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/24.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "RYDataBaseRecord.h"

@interface TestModel : RYDataBaseRecord

@property (nonatomic, copy) NSNumber *primaryKey;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *age;
@property (nonatomic, copy) NSNumber *stuClass;
@property (nonatomic, copy) NSString *tomas;

@end