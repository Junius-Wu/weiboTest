//
//  WJTabBarWithPlusBtn.m
//  160323-微博
//
//  Created by Jun on 16/3/25.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJTabBarWithPlusBtn.h"
@interface WJTabBarWithPlusBtn ()
@property (nonatomic, weak) UIButton *plusBtn;
@end
@implementation WJTabBarWithPlusBtn

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];

        btn.size = CGSizeMake(76, 48);
        [btn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
        self.plusBtn = btn;
    }
    return self;
}
/**
 *  点击了加号按钮
 */
- (void) plusBtnClick {
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton)]) {
        [self.delegate tabBarDidClickPlusButton];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    self.plusBtn.centerX = self.width / 2;
    self.plusBtn.centerY = self.height / 2;
    
    
    CGFloat btnW = self.width / 5;
    
    int index = 0;
    //设置位置
    for (UIView * view in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            view.x = (index++) * btnW;
            index = index == 2 ? ++index : index;
            view.width = btnW;
        }
    }

}

@end
