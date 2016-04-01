//
//  UIWindow+WJExtension.m
//  160323-微博
//
//  Created by Jun on 16/3/29.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "UIWindow+WJExtension.h"
#import "WJTabBarController.h"
#import "WJNewFeatureController.h"

@implementation UIWindow (WJExtension)

- (void)showNewFeatureOrNot {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:@"CFBundleVersion"];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    if ([lastVersion isEqualToString:currentVersion]) { //不是新版本
        [self setRootViewController:[[WJTabBarController alloc] init]];
    } else { //是新版本 显示新特性
        [self setRootViewController:[[WJNewFeatureController alloc] init]];
        [defaults setObject:currentVersion forKey:@"CFBundleVersion"];
        [defaults synchronize];
    }
}

@end
