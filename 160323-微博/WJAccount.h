//
//  WJAccount.h
//  160323-微博
//
//  Created by Jun on 16/3/29.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "access_token" = "2.00kdfDPGnvJ7xD0947e40cc4pO762E";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 5719317084;
 
 */

@interface WJAccount : NSObject <NSCoding>
/**
 *  用户的id 
 */
@property (nonatomic, copy) NSString *uid;
/**
 *  accessToken
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  经过多少秒后accessToken过期
 */
@property (nonatomic, copy) NSNumber *expires_in;

/**
 *  过期时间
 */
@property (nonatomic, strong) NSDate *time_limit;
/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;



@end
