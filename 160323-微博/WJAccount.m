//
//  WJAccount.m
//  160323-微博
//
//  Created by Jun on 16/3/29.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJAccount.h"

@implementation WJAccount
//归档
- (void)encodeWithCoder:(NSCoder *)encode {
    [encode encodeObject:self.uid forKey:@"uid"];
    [encode encodeObject:self.access_token forKey:@"access_token"];
    [encode encodeObject:self.expires_in forKey:@"expires_in"];
    [encode encodeObject:self.time_limit forKey:@"time_limit"];
    [encode encodeObject:self.name forKey:@"name"];
}


//解档
- (instancetype)initWithCoder:(NSCoder *)decode {
    self.uid = [decode decodeObjectForKey:@"uid"];
    self.access_token = [decode decodeObjectForKey:@"access_token"];
    self.expires_in = [decode decodeObjectForKey:@"expires_in"];
    self.time_limit = [decode decodeObjectForKey:@"time_limit"];
    self.name = [decode decodeObjectForKey:@"name"];
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    WJAccount *account = [[WJAccount alloc] init];
    account.uid = dict[@"uid"];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    //计算过期时间
    NSDate *now = [NSDate date];
    long long expires_in = [account.expires_in longLongValue];
    account.time_limit = [now dateByAddingTimeInterval:expires_in];
    
    return account;
}


@end
