//
//  WJLabel.h
//  160323-微博
//
//  Created by Jun on 16/4/7.
//  Copyright © 2016年 Jun. All rights reserved.
//  可以设置aligment为top bottom

#import <UIKit/UIKit.h>
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface WJLabel : UILabel
{
@private
    VerticalAlignment _verticalAlignment;
}
/**
 *  VerticalAlignmentTop = 0, // 顶部
    VerticalAlignmentMiddle,//中间
    VerticalAlignmentBottom,//底部
 */
@property (nonatomic) VerticalAlignment verticalAlignment;

@end