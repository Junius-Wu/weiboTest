//
//  WJSearchView.m
//  160323-微博
//
//  Created by Jun on 16/3/24.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJSearchView.h"
#import "UIView+Extension.h"

@implementation WJSearchView


+ (WJSearchView *)searchViewWithSize:(CGSize)size {
    WJSearchView *searchView = [[WJSearchView alloc] init];
    
    searchView.size = size;
    searchView.placeholder = @"请输入搜索条件";
    searchView.font = [UIFont systemFontOfSize:13];
    [searchView setBackground:[UIImage imageNamed:@"searchbar_textfield_background"]];
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    bgImage.size = CGSizeMake(30, 30);
    bgImage.contentMode = UIViewContentModeCenter;
    searchView.leftView = bgImage;
    searchView.leftViewMode = UITextFieldViewModeAlways;

    return searchView;
}




@end
