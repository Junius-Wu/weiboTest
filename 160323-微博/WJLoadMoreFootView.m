//
//  WJLoadMoreFootView.m
//  160323-微博
//
//  Created by Jun on 16/3/30.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJLoadMoreFootView.h"

@implementation WJLoadMoreFootView

+(instancetype)footerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"WJLoadMoreFootView" owner:nil options:nil] lastObject];
}

@end
