//
//  WJAccountTool.h
//  160323-微博
//
//  Created by Jun on 16/3/29.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJAccount.h"

@interface WJAccountTool : NSObject
/**
 *  保存账号信息到沙盒
 */
+ (void)saveAccount:(WJAccount *)account;
/**
 *  从沙盒中读取账号信息
 */
+ (WJAccount *)account;

@end
