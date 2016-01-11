//
//  NSArray+TransformItemsToClass.m
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "NSArray+TransformItemsToClass.h"

@implementation NSArray (TransformItemsToClass)

- (NSArray *)transformSQLItemsToClass:(Class)classType
{
    NSMutableArray *recordList = [[NSMutableArray alloc] init];
    if ([self count] > 0) {
        [self enumerateObjectsUsingBlock:^(NSDictionary * recordInfo, NSUInteger idx, BOOL * stop) {
            id <RYDataBaseRecordProtocol> record = [[classType alloc] init];
            if ([record respondsToSelector:@selector(objectRepresentationWithDictionary:)]) {
                [record objectRepresentationWithDictionary:recordInfo];
                [recordList addObject:record];
            }
        }];
    }
    return recordList;
}

@end
