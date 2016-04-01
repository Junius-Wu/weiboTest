//
//  WJDropdownMenu.h
//  160323-微博
//
//  Created by Jun on 16/3/24.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WJDropdownMenuDelegate <NSObject>

@optional

- (void)dropdownMenuDidDismiss;

@end


@interface WJDropdownMenu : UIView
+(WJDropdownMenu *)menuWithSizeOfViewController:(CGSize)size;
- (void) showFrom:(UIView *)from;
- (void) dismiss;
@property (nonatomic, strong) UIViewController *contentController;

@property (nonatomic, strong) UIImageView *contentImage;

@property (nonatomic, strong) UIView *content;

@property (nonatomic, weak) id<WJDropdownMenuDelegate> delegate;

@end
