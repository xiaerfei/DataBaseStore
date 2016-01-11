//
//  RYDataBaseTable+FetchMethods.h
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "RYDataBaseTable.h"

@interface RYDataBaseTable (FetchMethods)
/**
 *  create SELECT part of SQL.
 *
 *  You should never use this method directly, use Fetch methods in RYDataBaseTable instead.
 *
 *  @param columList  SELECT column list
 *  @param isDistinct if YES, will use SELECT DISTINCT when generating SQL
 *
 *  @return return NSString
 */
- (NSString *)select:(NSString *)columList isDistinct:(BOOL)isDistinct;

/**
 *  create FROM part of SQL.
 *
 *  You should never use this method directly, use Fetch methods in RYDataBaseTable instead.
 *
 *  @param fromList FROM part in SQL
 *
 *  @return return NSString
 */
- (NSString *)from:(NSString *)fromList;

/**
 *  create WHERE part of SQL.
 *
 *  You should never use this method directly, use Fetch methods in RYDataBaseTable instead.
 *
 *  @param condition where condition
 *  @param params    params for where condition
 *
 *  @return return NSString
 *
 *  @warning You should never use this method directly, use insert methods in RYDataBaseTable instead
 *
 */
- (NSString *)where:(NSString *)condition params:(NSDictionary *)params;

/**
 *  create ORDER BY part of SQL
 *
 *  You should never use this method directly, use Fetch methods in RYDataBaseTable instead.
 *
 *  @param orderBy ORDER BY part of SQL
 *  @param isDESC  if YES, use DESC, if NO, use ASC
 *
 *  @return return NSString
 *
 *  @warning You should never use this method directly, use insert methods in RYDataBaseTable instead
 *
 */
- (NSString *)orderBy:(NSString *)orderBy isDESC:(BOOL)isDESC;

/**
 *  create LIMIT part of SQL
 *
 *  You should never use this method directly, use Fetch methods in RYDataBaseTable instead.
 *
 *  @param limit limit count
 *
 *  @return return NSString
 *
 *  @warning You should never use this method directly, use insert methods in RYDataBaseTable instead
 *
 */
- (NSString *)limit:(NSInteger)limit;

/**
 *  create OFFSET part of SQL
 *
 *  You should never use this method directly, use Fetch methods in RYDataBaseTable instead.
 *
 *  @param offset offset
 *
 *  @return return NSString
 *
 *  @warning You should never use this method directly, use insert methods in RYDataBaseTable instead
 *
 */
- (NSString *)offset:(NSInteger)offset;

/**
 *  Handy method to create LIMIT and OFFSET part of SQL
 *
 *  You should never use this method directly, use Fetch methods in RYDataBaseTable instead.
 *
 *  @param limit  limit count
 *  @param offset offset
 *
 *  @return return NSString
 *
 *  @warning You should never use this method directly, use insert methods in RYDataBaseTable instead
 *
 */
- (NSString *)limit:(NSInteger)limit offset:(NSInteger)offset;

@end
