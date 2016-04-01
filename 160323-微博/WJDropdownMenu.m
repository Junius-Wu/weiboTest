//
//  WJDropdownMenu.m
//  160323-微博
//
//  Created by Jun on 16/3/24.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJDropdownMenu.h"
#import "UIView+Extension.h"

@implementation WJDropdownMenu



+ (WJDropdownMenu *)menuWithSizeOfViewController:(CGSize)size {
    
    WJDropdownMenu *menu = [[WJDropdownMenu alloc] init];
    //根据控制器size 设置frame
    menu.content.size = size;
    menu.content.origin = CGPointMake(15, 15);
    
    //[menu.content setBackgroundColor:[UIColor greenColor]];
    
    menu.contentImage.size = CGSizeMake(size.width + 30, size.height + 30);
    return menu;
}


- (UIImageView *)contentImage {
    if (_contentImage == nil) {
        UIImageView *contenImage = [[UIImageView alloc] init];
        contenImage.image = [UIImage imageNamed:@"popover_background"];
        contenImage.userInteractionEnabled = YES;
        _contentImage = contenImage;
        [self addSubview:_contentImage];
    }
    return _contentImage;
    
}

- (UIView *)content {
    if (_content == nil) {
        UIView *content = [[UIView alloc] init];
        [content setBackgroundColor:[UIColor redColor]];
        _content = content;
        [self.contentImage addSubview:_content];
    }
    return _content;
}

-(void)setContentController:(UIViewController *)contentController {
    _contentController = contentController;
    [self.content addSubview:contentController.view];
//    self.content = _contentController.view;
}

- (void) showFrom:(UIView *)from{
    //最上层的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    
    //根据from 的xy设置image的xy
    self.contentImage.centerX = CGRectGetMidX(newFrame);
    self.contentImage.y = CGRectGetMaxY(newFrame);
    self.frame = window.bounds;
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss)]) {
        [self.delegate dropdownMenuDidDismiss];
    }
    
}

-(void)dismiss {
    [self removeFromSuperview];
}

@end
