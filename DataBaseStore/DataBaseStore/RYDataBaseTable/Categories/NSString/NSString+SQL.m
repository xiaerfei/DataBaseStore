//
//  NSString+SQL.m
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/24.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "NSString+SQL.h"

@implementation NSString (SQL)


- (NSString *)stringWithSQLParams:(NSDictionary *)params
{
    NSMutableArray *keyList = [[NSMutableArray alloc] init];
    
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@":[\\w]*" options:0 error:NULL];
    
    NSArray *list = [expression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    [list enumerateObjectsUsingBlock:^(NSTextCheckingResult * checkResult, NSUInteger idx, BOOL * stop) {
        NSString *subString = [self substringWithRange:checkResult.range];
        [keyList addObject:[subString substringWithRange:NSMakeRange(1, subString.length-1)]];
    }];
    
    NSMutableString *resultString = [self mutableCopy];
    [keyList enumerateObjectsUsingBlock:^(NSString * key, NSUInteger idx, BOOL * stop) {
        if (params[key]) {
            NSRegularExpression *expressionForReplace = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@":%@\\b", key] options:0 error:NULL];
            NSString *value = [NSString stringWithFormat:@"%@", params[key]];
            [expressionForReplace replaceMatchesInString:resultString options:0 range:NSMakeRange(0, resultString.length) withTemplate:value];
        }
    }];
    
    return resultString;
}

- (NSString *)safeSQLMetaString
{
    //FIXME: 这里有bug，待修复，包含 '` 符号的会被干掉
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"'`"];
    return [[self componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
}
@end
