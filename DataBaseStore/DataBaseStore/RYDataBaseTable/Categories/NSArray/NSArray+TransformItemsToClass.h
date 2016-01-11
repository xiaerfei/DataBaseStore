//
//  NSArray+TransformItemsToClass.h
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RYDataBaseRecord.h"

@interface NSArray (TransformItemsToClass)

- (NSArray *)transformSQLItemsToClass:(Class<RYDataBaseRecordProtocol>)classType;

@end
