//
//  WJTextView.m
//  160323-微博
//
//  Created by Jun on 16/4/7.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJTextView.h"
#import "WJLabel.h"
#define WJTextViewFont [UIFont systemFontOfSize:15]
@interface WJTextView ()

@property (nonatomic, weak) WJLabel *placeHolderLabel;
@end
@implementation WJTextView

//代码创建时调用这个方法， 设置一些自定义控件
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
      self.font = WJTextViewFont;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
//当监听到text发生改变时
- (void)textDidChange:(WJTextView *)textView {
    self.placeHolderLabel.hidden = (self.hasText);
    
}

//设置一个label作为placeholder
- (void)setPlaceHolderLabel {
    WJLabel *label = [[WJLabel alloc] init];
    label.numberOfLines = 0;
    label.verticalAlignment = VerticalAlignmentTop;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:self.placeHolder attributes:attrs];
    label.attributedText = attributeString;
    label.frame = CGRectMake(5, 8, [UIScreen mainScreen].bounds.size.width - 10, [UIScreen mainScreen].bounds.size.height - 16 - 64);
    [self addSubview:label];
    self.placeHolderLabel = label;
    
}
//重写set方法 ，当发生改变时重新设置placeholder
-(void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = [placeHolder copy];
    [self setPlaceHolderLabel];
}



@end
