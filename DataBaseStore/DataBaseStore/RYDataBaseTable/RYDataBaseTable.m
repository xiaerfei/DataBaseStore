//
//  RYDataBaseTable.m
//  RYDataBaseStore
//
//  Created by xiaerfei on 15/11/8.
//  Copyright © 2015年 geren. All rights reserved.
//

#import "RYDataBaseTable.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "RYDataBaseTable+AnalyzeSQL.h"
#import "NSString+SQL.h"
#import "RYDataBaseRecordProtocol.h"
#import "NSArray+TransformItemsToClass.h"
#import "RYDataBaseCriteria.h"

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface RYDataBaseTable ()

@property (nonatomic, strong) FMDatabaseQueue * dbQueue;

@property (nonatomic, copy, readwrite) NSString *dbPath;

@property (nonatomic, weak) id<RYDataBaseTableProtocol> child;

@end

@implementation RYDataBaseTable
#pragma mark - Lift Cycle
- (instancetype)init
{
    self = [super init];
    if (self && [self conformsToProtocol:@protocol(RYDataBaseTableProtocol)]) {
        self.child = (RYDataBaseTable <RYDataBaseTableProtocol> *)self;
        
        NSString *cachePaht = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"PersonOutLocationRecord"];
        NSString * dbPath = [cachePaht stringByAppendingPathComponent:[self.child databaseName]];
        self.dbPath = dbPath;
        NSLog(@"%@",dbPath);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:cachePaht] == NO) {
            [fileManager createDirectoryAtPath:cachePaht withIntermediateDirectories:YES attributes:nil error:NULL];
        }
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        
        [self createColumnInfo:[self.child columnInfo]];
        
    } else {
        NSException *exception = [NSException exceptionWithName:@"RYDataBaseTable init error" reason:@"the child class must conforms to protocol: <RYDataBaseTableProtocol>" userInfo:nil];
        @throw exception;
    }
    return self;
}



- (void)dealloc
{
    [self closeDataBase];
}

#pragma mark - Public methods

#pragma mark Insert Data
- (BOOL)insertDataList:(NSArray *)dataList
{
    NSString * sql = [self analyzeOfInsertTableWithTabelName:[self.child tableName] dataList:dataList];
    return [self executeWithSql:sql];
}

- (BOOL)insertDataClassList:(NSArray *)dataClassList
{
    NSMutableArray *dataClassInfoArray = [[NSMutableArray alloc] init];
    [dataClassList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id <RYDataBaseRecordProtocol> record = obj;
        NSDictionary *classInfo = [record dictionaryRepresentationWithTable:self.child shouldOverride:YES];
        [dataClassInfoArray addObject:classInfo];
    }];
    return [self insertDataList:dataClassInfoArray];
}

- (BOOL)replaceDataList:(NSArray *)dataList
{
    NSString * sql = [self analyzeOfReplaceTableWithTabelName:[self.child tableName] dataList:dataList];
    return [self executeWithSql:sql];
}

- (BOOL)replaceDataClassList:(NSArray *)dataClassList
{
    NSMutableArray *dataClassInfoArray = [[NSMutableArray alloc] init];
    [dataClassList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id <RYDataBaseRecordProtocol> record = obj;
        NSDictionary *classInfo = [record dictionaryRepresentationWithTable:self.child shouldOverride:YES];
        [dataClassInfoArray addObject:classInfo];
    }];
    return [self replaceDataList:dataClassInfoArray];
}

#pragma mark Update Data
- (BOOL)updateKeyValueList:(NSDictionary *)keyValueList whereConditionParam:(NSDictionary *)conditionParam
{
    NSString * sql = [self analyzeOfUpdateTableWithTabelName:[self.child tableName] columnInfo:keyValueList primary:conditionParam];
    return [self executeWithSql:sql];
}

- (BOOL)updateDataClass:(id)dataClass whereConditionParam:(NSDictionary *)conditionParam shouldOverride:(BOOL)shouldOverride
{
    id <RYDataBaseRecordProtocol> record = dataClass;
    NSDictionary *classInfo = [record dictionaryRepresentationWithTable:self.child shouldOverride:shouldOverride];
    NSString *sql = [self analyzeOfUpdateTableWithTabelName:[self.child tableName] columnInfo:classInfo primary:conditionParam];
    return [self executeWithSql:sql];
}


- (void)updateDataClassList:(NSArray *)dataClassList whereConditionParam:(NSDictionary *)conditionParam shouldOverride:(BOOL)shouldOverride
{
    NSMutableArray *dataClassInfoArray = [[NSMutableArray alloc] init];
    [dataClassList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id <RYDataBaseRecordProtocol> record = obj;
        NSDictionary *classInfo = [record dictionaryRepresentationWithTable:self.child shouldOverride:shouldOverride];
        [dataClassInfoArray addObject:classInfo];
    }];
    
    NSMutableArray *sqlArray = [[NSMutableArray alloc] init];
    [dataClassInfoArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       NSString * sql = [self analyzeOfUpdateTableWithTabelName:[self.child tableName] columnInfo:obj primary:conditionParam];
        [sqlArray addObject:sql];
    }];

    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (NSString *sql in sqlArray) {
            BOOL result = [db executeUpdate:sql];
            if (result == NO) {
                *rollback = YES;
            }
        }
    }];
}


- (BOOL)updateKeyValueList:(NSDictionary *)keyValueList whereCondition:(NSString *)condition conditionParam:(NSDictionary *)conditionParam
{
    NSString *sql = [NSString stringWithFormat:@"%@ WHERE %@;",[self analyzeOfUpdateTableWithTabelName:[self.child tableName] columnInfo:keyValueList primary:nil],[condition stringWithSQLParams:conditionParam]];
    return [self executeWithSql:sql];
}
#pragma mark Fetch Data
- (NSDictionary *)countWithSQL:(NSString *)sqlString params:(NSDictionary *)params
{
    NSString *sql = [sqlString stringWithSQLParams:params];
    return [[self fetchDataWithSql:sql] firstObject];
}

- (NSNumber *)countTotalRecord
{
    NSString *sqlString = [NSString stringWithFormat:@"SELECT COUNT(*) as count FROM %@", self.child.tableName];
    NSDictionary *countResult = [self countWithSQL:sqlString params:nil];
    return countResult[@"count"];
}

- (NSNumber *)countWithWhereCondition:(NSString *)whereCondition conditionParams:(NSDictionary *)conditionParams
{
    NSString *sqlString = @"SELECT COUNT(*) AS count FROM :tableName WHERE :whereString;";
    NSString *whereString = [whereCondition stringWithSQLParams:conditionParams];
    NSString *tableName = self.child.tableName;
    NSDictionary *params = NSDictionaryOfVariableBindings(whereString, tableName);
    NSDictionary *countResult = [self countWithSQL:sqlString params:params];
    return countResult[@"count"];
}

- (NSArray *)fetchDataWithWhereCondition:(NSString *)condition conditionParams:(NSDictionary *)conditionParams isDistinct:(BOOL)isDistinct isTransformItemsToClass:(BOOL)isTransformItemsToClass
{
    RYDataBaseCriteria *criteria = [[RYDataBaseCriteria alloc] init];
    criteria.isDistinct = isDistinct;
    criteria.whereCondition = condition;
    criteria.whereConditionParams = conditionParams;
    return [self fetchAllWithCriteria:criteria isTransformItemsToClass:isTransformItemsToClass];
}

- (NSArray *)fetchAllWithCriteria:(RYDataBaseCriteria *)criteria isTransformItemsToClass:(BOOL)isTransformItemsToClass
{
    NSString *sqlString = [criteria applyToSelectDataBaseTable:self tableName:[self.child tableName]];
    NSArray *fetchedResult = [self fetchDataWithSql:sqlString];
    if (isTransformItemsToClass) {
        return [fetchedResult transformSQLItemsToClass:[self.child recordClass]];
    } else {
        return fetchedResult;
    }
}
#pragma mark Delete Data
- (BOOL)deleteWithCriteria:(RYDataBaseCriteria *)criteria
{
    NSString *sqlString = [criteria applyToDeleteDataBaseTable:self tableName:[self.child tableName]];
    return [self executeWithSql:sqlString];
}

- (BOOL)deleteWithWhereCondition:(NSString *)whereCondition conditionParams:(NSDictionary *)conditionParams
{
    RYDataBaseCriteria *criteria = [[RYDataBaseCriteria alloc] init];
    criteria.whereCondition = whereCondition;
    criteria.whereConditionParams = conditionParams;
    return [self deleteWithCriteria:criteria];
}

- (BOOL)deleteWithPrimaryKey:(NSNumber *)primaryKeyValue
{
    if (primaryKeyValue) {
        RYDataBaseCriteria *criteria = [[RYDataBaseCriteria alloc] init];
        criteria.whereCondition = [NSString stringWithFormat:@"%@ = :primaryKeyValue", [self.child primaryKeyName]];
        criteria.whereConditionParams = NSDictionaryOfVariableBindings(primaryKeyValue);
        return [self deleteWithCriteria:criteria];
    } else {
        return NO;
    }
}
- (BOOL)deleteWithPrimaryKeyList:(NSArray *)primaryKeyValueList
{
    if ([primaryKeyValueList count] > 0) {
        NSString *primaryKeyValueListString = [primaryKeyValueList componentsJoinedByString:@","];
        RYDataBaseCriteria *criteria = [[RYDataBaseCriteria alloc] init];
        criteria.whereCondition = [NSString stringWithFormat:@"%@ IN (:primaryKeyValueListString)", [self.child primaryKeyName]];
        criteria.whereConditionParams = NSDictionaryOfVariableBindings(primaryKeyValueListString);
        return [self deleteWithCriteria:criteria];
    } else {
        return NO;
    }
}

- (BOOL)deleteDataClass:(NSObject <RYDataBaseRecordProtocol> *)dataClass
{
    return [self deleteWithPrimaryKey:[dataClass valueForKey:[self.child primaryKeyName]]];
}

- (BOOL)deleteDataClassList:(NSArray *)dataClassList
{
    NSMutableArray *primatKeyList = [[NSMutableArray alloc] init];
    [dataClassList enumerateObjectsUsingBlock:^(NSObject <RYDataBaseRecordProtocol> * record, NSUInteger idx, BOOL * stop) {
        NSNumber *primaryKeyValue = [record valueForKey:[self.child primaryKeyName]];
        if (primaryKeyValue) {
            [primatKeyList addObject:primaryKeyValue];
        }
    }];
    return [self deleteWithPrimaryKeyList:primatKeyList];
}

- (BOOL)deleteWithSql:(NSString *)sqlString params:(NSDictionary *)params
{
    NSString *finalSql = [sqlString stringWithSQLParams:params];
    return [self executeWithSql:finalSql];
}


#pragma mark Close DataBase
- (void)closeDataBase
{
    [_dbQueue close];
    _dbQueue = nil;
}

#pragma mark - Private methods

- (BOOL)createColumnInfo:(NSDictionary *)columnInfo
{
    NSString * sql = [self analyzeOfCreateTableWithTabelName:[self.child tableName] columnInfo:columnInfo];
    return [self executeWithSql:sql];
}

- (BOOL)executeWithSql:(NSString *)sql
{
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
        if (result == NO) {
            NSLog(@"%@",db.lastError);
        }
    }];
    return result;
}

- (NSArray *)fetchDataWithSql:(NSString *)sql
{
    __block NSMutableArray *fetchArray = [[NSMutableArray alloc] init];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            [fetchArray addObject:rs.resultDictionary];
        }
        [rs close];
    }];
    return fetchArray;
}



@end
