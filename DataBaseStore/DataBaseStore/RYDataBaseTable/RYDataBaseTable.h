//
//  RYDataBaseTable.h
//  RYDataBaseStore
//
//  Created by xiaerfei on 15/11/8.
//  Copyright © 2015年 geren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RYDataBaseCriteria;
@protocol RYDataBaseRecordProtocol;

@protocol RYDataBaseTableProtocol <NSObject>

@required
/**
 *  return the name of databse file, RYDataBaseTableProtocol will create CTDatabase by this string.
 *
 *  @return return the name of database file
 */
- (NSString *)databaseName;

/**
 *  the name of your table
 *
 *  @return return the name of your table
 */
- (NSString *)tableName;

/**
 *  column info with this table. If table not exists in database, RYDataBaseTable will create a table based on the column info you provided
 *
 *  @return return the column info of your table
 */
- (NSDictionary *)columnInfo;
/**
 *  the name of the primary key.
 *
 *  @return return the name of the primary key.
 */
- (NSString *)primaryKeyName;

/**
 *  the Class of the record.
 *
 *  RYDataBaseTable will transform data into the object of recordClass
 *
 *  @return return the class of the record
 */
- (Class)recordClass;


@optional

- (NSString *)unique;

@end



@interface RYDataBaseTable : NSObject

@property (nonatomic, weak, readonly) RYDataBaseTable <RYDataBaseTableProtocol> *child;

@property (nonatomic, copy, readonly) NSString *dbPath;

/**
 *   @author xiaerfei, 15-11-24 20:11:04
 *
 *   insert data
 *
 *   @param tableName tableName
 *   @param dataList  dataList
 *
 *   @return is failed
 */
- (BOOL)insertDataList:(NSArray *)dataList;
/**
 *   @author xiaerfei, 15-11-24 20:11:00
 *
 *   insert data of Class
 *
 *   @param tableName     tableName
 *   @param dataClassList dataClassList
 *
 *   @return is failed
 */
- (BOOL)insertDataClassList:(NSArray *)dataClassList;
/**
 *   @author xiaerfei, 15-12-03 16:12:59
 *
 *   Insert Or Update Data
 *
 *   @param dataList dataList
 *
 *   @return is failed
 */
- (BOOL)replaceDataList:(NSArray *)dataList;
/**
 *   @author xiaerfei, 15-12-03 16:12:34
 *
 *   Insert Or Update Data Of Class
 *
 *   @param dataClassList dataClassList
 *
 *   @return is failed
 */
- (BOOL)replaceDataClassList:(NSArray *)dataClassList;
/**
 *   @author xiaerfei, 15-11-24 20:11:01
 *
 *   update data
 *
 *   @param tableName      tableName
 *   @param keyValueList   keyValueList
 *   @param conditionParam update param
 *
 *   @return is failed
 */
- (BOOL)updateKeyValueList:(NSDictionary *)keyValueList whereConditionParam:(NSDictionary *)conditionParam;
/**
 *   @author xiaerfei, 15-11-24 20:11:36
 *
 *   update data Class
 *
 *   @param tableName      tableName
 *   @param dataClass      dataClass
 *   @param conditionParam update param
 *   @param shouldOverride is override data
 *
 *   @return is failed
 */
- (BOOL)updateDataClass:(id)dataClass whereConditionParam:(NSDictionary *)conditionParam shouldOverride:(BOOL)shouldOverride;
/**
 *   @author xiaerfei, 15-11-24 20:11:52
 *
 *   update data array
 *
 *   @param tableName      tableName
 *   @param dataClassList  dataClassList
 *   @param conditionParam update param
 *   @param shouldOverride is override data
 */
- (void)updateDataClassList:(NSArray *)dataClassList whereConditionParam:(NSDictionary *)conditionParam shouldOverride:(BOOL)shouldOverride;
/**
 *   @author xiaerfei, 15-11-24 20:11:39
 *
 *   update data common
 *
 *   @param tableName      tableName
 *   @param keyValueList   keyValueList
 *   @param condition      condition
 *   @param conditionParam conditionParam
 *
 *   @return is failed
 */
- (BOOL)updateKeyValueList:(NSDictionary *)keyValueList whereCondition:(NSString *)condition conditionParam:(NSDictionary *)conditionParam;
/**
 *   @author xiaerfei, 15-11-25 09:11:13
 *
 *   record count of record list with matches where condition
 *
 *   @param sqlString SQL
 *   @param params    where condition params
 *
 *   @return a dictionary which contains count column.
 */
- (NSDictionary *)countWithSQL:(NSString *)sqlString params:(NSDictionary *)params;
/**
 *   @author xiaerfei, 15-11-25 09:11:31
 *
 *   record count of record list with matches where condition
 *
 *   @return total record count in this table
 */
- (NSNumber *)countTotalRecord;
/**
 *   @author xiaerfei, 15-11-25 09:11:27
 *
 *   record count of record list with matches where condition
 *
 *   @param whereCondition  whereCondition
 *   @param conditionParams conditionParams
 *
 *   @return record count of record list with matches where condition
 */
- (NSNumber *)countWithWhereCondition:(NSString *)whereCondition conditionParams:(NSDictionary *)conditionParams;


/**
 *   @author xiaerfei, 15-11-25 14:11:36
 *
 *   fetch all data with where condition
 *
 *   @param condition               condition
 *   @param conditionParams         conditionParams
 *   @param isDistinct              isDistinct
 *   @param isTransformItemsToClass is transform items to class
 *
 *   @return fetch data list
 */
- (NSArray *)fetchDataWithWhereCondition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams isDistinct:(BOOL)isDistinct isTransformItemsToClass:(BOOL)isTransformItemsToClass;
/**
 *   @author xiaerfei, 15-11-25 14:11:57
 *
 *   more fine search condition
 *
 *   @param criteria                criteria
 *   @param isTransformItemsToClass is transform items to class
 *
 *   @return fetch data list
 */
- (NSArray *)fetchAllWithCriteria:(RYDataBaseCriteria *)criteria isTransformItemsToClass:(BOOL)isTransformItemsToClass;
/**
 *   @author xiaerfei, 15-11-26 09:11:08
 *
 *   delete data with RYDataBaseCriteria
 *
 *   @param criteria criteria
 *
 *   @return is suceesss
 */
- (BOOL)deleteWithCriteria:(RYDataBaseCriteria *)criteria;
/**
 *   @author xiaerfei, 15-11-26 09:11:47
 *
 *   delete data with whereCondition
 *
 *   @param whereCondition  whereCondition
 *   @param conditionParams conditionParams
 *
 *   @return is suceesss
 */
- (BOOL)deleteWithWhereCondition:(NSString *)whereCondition conditionParams:(NSDictionary *)conditionParams;
/**
 *   @author xiaerfei, 15-11-26 09:11:37
 *
 *   delete data with primaryKeyValue
 *
 *   @param primaryKeyValue
 *
 *   @return is suceesss
 */
- (BOOL)deleteWithPrimaryKey:(NSNumber *)primaryKeyValue;
/**
 *   @author xiaerfei, 15-11-26 09:11:41
 *
 *   delete data with primaryKeyValueList
 *
 *   @param primaryKeyValueList
 *
 *   @return is suceesss
 */
- (BOOL)deleteWithPrimaryKeyList:(NSArray *)primaryKeyValueList;
/**
 *   @author xiaerfei, 15-11-26 09:11:17
 *
 *   delete data with dataClass
 *
 *   @param dataClass
 *
 *   @return is suceesss
 */
- (BOOL)deleteDataClass:(NSObject <RYDataBaseRecordProtocol> *)dataClass;
/**
 *   @author xiaerfei, 15-11-26 09:11:43
 *
 *   delete data with dataClassList
 *
 *   @param dataClassList
 *
 *   @return is suceesss
 */
- (BOOL)deleteDataClassList:(NSArray *)dataClassList;
/**
 *   @author xiaerfei, 15-11-26 09:11:09
 *
 *   delete data with sql
 *
 *   @param sqlString
 *   @param params
 *
 *   @return is suceesss
 */
- (BOOL)deleteWithSql:(NSString *)sqlString params:(NSDictionary *)params;
/**
 *   @author xiaerfei, 15-11-25 15:11:41
 *
 *   close DataBase
 */
- (void)closeDataBase;


@end
