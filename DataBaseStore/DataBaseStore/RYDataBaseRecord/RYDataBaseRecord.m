//
//  RYDataBaseRecord.m
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "RYDataBaseRecord.h"
#import "RYDataBaseTable.h"
#import "objc/runtime.h"
#import "NSString+SQL.h"


@implementation RYDataBaseRecord
- (NSDictionary *)dictionaryRepresentationWithTable:(RYDataBaseTable<RYDataBaseTableProtocol> *)table shouldOverride:(BOOL)shouldOverride
{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableDictionary *propertyList = [[NSMutableDictionary alloc] init];
    while (count -- > 0) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[count])];
        id value = [self valueForKey:key];
        if (shouldOverride) {
            if (value == nil) {
                propertyList[key] = [NSNull null];
            } else {
                propertyList[key] = value;
            }
        } else {
            if (value != nil) {
                propertyList[key] = value;
            }
        }
    }
    free(properties);
    
    NSMutableDictionary *dictionaryRepresentation = [[NSMutableDictionary alloc] init];
    [table.columnInfo enumerateKeysAndObjectsUsingBlock:^(NSString * columnName, NSString * columnDescription, BOOL * stop) {
        if (propertyList[columnName]) {
            dictionaryRepresentation[columnName] = propertyList[columnName];
        }
    }];
    
    return dictionaryRepresentation;
}

- (void)objectRepresentationWithDictionary:(NSDictionary *)dictionary
{
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSString * value, BOOL * stop) {
        [self setPersistanceValue:value forKey:key];
    }];
}

- (BOOL)setPersistanceValue:(id)value forKey:(NSString *)key
{
    BOOL result = YES;
    NSString *setter = [NSString stringWithFormat:@"set%@%@:", [[key substringToIndex:1] capitalizedString], [key substringFromIndex:1]];
    if ([self respondsToSelector:NSSelectorFromString(setter)]) {
        if ([value isKindOfClass:[NSString class]]) {
            [self setValue:value forKey:key];
        } else if ([value isKindOfClass:[NSNull class]]) {
            [self setValue:nil forKey:key];
        } else {
            [self setValue:value forKey:key];
        }
    } else {
        result = NO;
    }
    
    return result;
}

- (id <RYDataBaseRecordProtocol>)mergeRecord:(NSObject<RYDataBaseRecordProtocol> *)record shouldOverride:(BOOL)shouldOverride
{
    if ([self respondsToSelector:@selector(availableKeyList)]) {
        NSArray *availableKeyList = [self availableKeyList];
        [availableKeyList enumerateObjectsUsingBlock:^(NSString * key, NSUInteger idx, BOOL * stop) {
            if ([record respondsToSelector:NSSelectorFromString(key)]) {
                id recordValue = [record valueForKey:key];
                if (shouldOverride) {
                    [self setPersistanceValue:recordValue forKey:key];
                } else {
                    id selfValue = [self valueForKey:key];
                    if (selfValue == nil) {
                        [self setPersistanceValue:recordValue forKey:key];
                    }
                }
            }
        }];
    }
    return self;
}
@end
