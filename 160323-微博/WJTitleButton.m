//
//  WJDropdownMenu.m
//  160323-微博
//
//  Created by Jun on 16/3/24.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJTitleButton.h"
#import "UIView+Extension.h"

@implementation WJTitleButton

+ (WJTitleButton *)titleButtonWithTitle:(NSString *)title {
    
    WJTitleButton *btn = [WJTitleButton buttonWithType:UIButtonTypeCustom];
    btn.size = CGSizeMake(300, 40);
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
    return btn;
}


@end
