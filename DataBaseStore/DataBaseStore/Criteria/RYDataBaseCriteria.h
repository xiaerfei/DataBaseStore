//
//  RYDataBaseCriteria.h
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RYDataBaseTable;

@interface RYDataBaseCriteria : NSObject
/**
 *  the table or table list which connected with comma(,) to be select.
 */
@property (nonatomic, copy) NSString *select;

/**
 *  the condition in WHERE
 */
@property (nonatomic, copy) NSString *whereCondition;

/**
 *  params for whereCondition
 */
@property (nonatomic, copy) NSDictionary *whereConditionParams;

/**
 *  the key to order
 */
@property (nonatomic, copy) NSString *orderBy;

/**
 *  if YES, will generate DESC in ORDER BY clause. if NO, will generate ASC in ORDER BY clause
 */
@property (nonatomic, assign) BOOL isDESC;

/**
 *  the limit count
 */
@property (nonatomic, assign) NSInteger limit;

/**
 *  the offset to fetch
 */
@property (nonatomic, assign) NSInteger offset;

/**
 *  if YES, will generate SELECT DISTINCT, if NO, will generate SELECT
 */
@property (nonatomic, assign) BOOL isDistinct;


- (NSString *)applyToSelectDataBaseTable:(RYDataBaseTable *)dataBaseTable tableName:(NSString *)tableName;
- (NSString *)applyToDeleteDataBaseTable:(RYDataBaseTable *)dataBaseTable tableName:(NSString *)tableName;
@end
