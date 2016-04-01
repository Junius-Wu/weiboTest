//
//  WJAccountTool.m
//  160323-微博
//
//  Created by Jun on 16/3/29.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJAccountTool.h"
#define WJAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"account.archive"]

@implementation WJAccountTool

+ (void)saveAccount:(WJAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:WJAccountPath];
}

+ (WJAccount *)account {
    WJAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:WJAccountPath];
    NSComparisonResult results = [account.time_limit compare:[NSDate date]];
    if (results != NSOrderedDescending) {//说明过期
        return nil;
    }
    return account;
}
@end
