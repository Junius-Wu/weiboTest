//
//  WJTabBarWithPlusBtn.h
//  160323-微博
//
//  Created by Jun on 16/3/25.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WJTabBarWithPlusBtnDelegate <NSObject>

@optional
- (void)tabBarDidClickPlusButton;

@end

@interface WJTabBarWithPlusBtn : UITabBar


@property (nonatomic, weak) id<WJTabBarWithPlusBtnDelegate> delegate;
@end
