//
//  RYDataBaseRecord.h
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/25.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "RYDataBaseRecordProtocol.h"

//columnInfo

#define COLUMN_INFO(CLASS, PATH)           \
(((void)(NO && ((void)[CLASS new].PATH, NO)), @# PATH))


@interface RYDataBaseRecord : NSObject <RYDataBaseRecordProtocol>

@end
