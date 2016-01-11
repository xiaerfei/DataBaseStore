//
//  RYDataBaseTable+AnalyzeSQL.h
//  RYDataBaseStore
//
//  Created by xiaerfei on 15/11/8.
//  Copyright © 2015年 geren. All rights reserved.
//

#import "RYDataBaseTable.h"

@interface RYDataBaseTable (AnalyzeSQL)
/**
 *   @author xiaerfei, 15-11-11 14:11:18
 *
 *   analyze CREATE TABLE SQL
 *
 *   @param tableName  tableName
 *   @param columnInfo columnInfo
 *
 *   @return SQL
 */
- (NSString *)analyzeOfCreateTableWithTabelName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo;
/**
 *   @author xiaerfei, 15-11-11 14:11:27
 *
 *   analyze UPDATE SQL
 *
 *   @param tableName  tableName
 *   @param columnInfo columnInfo
 *   @param primary    primary
 *
 *   @return SQL
 */
- (NSString *)analyzeOfUpdateTableWithTabelName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo primary:(NSDictionary *)primary;
/**
 *   @author xiaerfei, 15-11-11 14:11:55
 *
 *   analyze INSERT SQL
 *
 *   @param tableName tableName
 *   @param dataList  dataList
 *
 *   @return SQL
 */
- (NSString *)analyzeOfInsertTableWithTabelName:(NSString *)tableName dataList:(NSArray *)dataList;
/**
 *   @author xiaerfei, 15-12-03 16:12:07
 *
 *   analyze REPLACE SQL Insert Or Update
 *
 *   @param tableName tableName
 *   @param dataList  dataList
 *
 *   @return SQL
 */
- (NSString *)analyzeOfReplaceTableWithTabelName:(NSString *)tableName dataList:(NSArray *)dataList;
/**
 *   @author xiaerfei, 15-11-24 15:11:58
 *
 *   analyze SELECT SQL
 *
 *   @param tableName tableName
 *   @param primary   primary
 *
 *   @return SQL
 */
- (NSString *)analyzeOfSelectTableWithTabelName:(NSString *)tableName primary:(NSDictionary *)primary;
/**
 *   @author xiaerfei, 15-11-26 19:11:32
 *
 *   analyze Delete SQL
 *
 *   @param tableName       tableName
 *   @param condition       condition
 *   @param conditionParams conditionParams
 *
 *   @return SQL
 */
- (NSString *)analyzeOfDelete:(NSString *)tableName withCondition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams;


@end
