//
//  RYDataBaseRecordProtocol.h
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RYDataBaseTable;
@protocol RYDataBaseTableProtocol;

@protocol RYDataBaseRecordProtocol <NSObject>

- (NSDictionary *)dictionaryRepresentationWithTable:(RYDataBaseTable <RYDataBaseTableProtocol> *)table shouldOverride:(BOOL)shouldOverride;

- (void)objectRepresentationWithDictionary:(NSDictionary *)dictionary;

- (BOOL)setPersistanceValue:(id)value forKey:(NSString *)key;

- (id <RYDataBaseRecordProtocol>)mergeRecord:(NSObject <RYDataBaseRecordProtocol> *)record shouldOverride:(BOOL)shouldOverride;

@optional

- (NSArray *)availableKeyList;
@end
