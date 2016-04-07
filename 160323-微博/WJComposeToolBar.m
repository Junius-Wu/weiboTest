//
//  WJComposeToolBar.m
//  160323-微博
//
//  Created by Jun on 16/4/7.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJComposeToolBar.h"

@implementation WJComposeToolBar

//初始化 添加拍照，相簿，@，#，表情，子控件
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        
        [self addButtonWithImageName:@"compose_camerabutton_background" highlightedImageName:@"compose_camerabutton_background_highlighted" type:WJComposeToolBarButtonTypeCamera];
        [self addButtonWithImageName:@"compose_emoticonbutton_background" highlightedImageName:@"compose_emoticonbutton_background_highlighted" type:WJComposeToolBarButtonTypeEmotion];
        [self addButtonWithImageName:@"compose_mentionbutton_background" highlightedImageName:@"compose_mentionbutton_background_highlighted" type:WJComposeToolBarButtonTypeMention];
        [self addButtonWithImageName:@"compose_toolbar_picture" highlightedImageName:@"compose_toolbar_picture_highlighted" type:WJComposeToolBarButtonTypePictrue];
        [self addButtonWithImageName:@"compose_trendbutton_background" highlightedImageName:@"compose_trendbutton_background_highlighted" type:WJComposeToolBarButtonTypeTrend];
        
    }
    return self;
}
- (void) addButtonWithImageName:(NSString *) name highlightedImageName:(NSString *)highlightedName type:(WJComposeToolBarButtonType)type {
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedName] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.tag = type;
    [self addSubview:btn];
}

- (void)btnClick:(UIButton *) button {
    WJLog(@"-------btn-------%d", button.tag);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //设置长条toolbar的frame
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - WJComposeToolBarHeight, [UIScreen mainScreen].bounds.size.width, WJComposeToolBarHeight);
    
    //设置按钮的frame
    CGFloat btnH = WJComposeToolBarHeight;
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width / numberOfButtonInComposeToolBar;
    int index = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            view.frame = CGRectMake(index * btnW, 0, btnW, btnH);
            index++;
        }
        
    }
}
@end
