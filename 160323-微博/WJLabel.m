//
//  WJLabel.m
//  160323-微博
//
//  Created by Jun on 16/4/7.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJLabel.h"

@implementation WJLabel
@synthesize verticalAlignment = verticalAlignment_;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.verticalAlignment = VerticalAlignmentMiddle;
    }
    return self;
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
    verticalAlignment_ = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop://顶部
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom://底部
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle://中间
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}


@end
