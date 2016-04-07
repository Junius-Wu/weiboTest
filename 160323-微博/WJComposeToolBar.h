//
//  WJComposeToolBar.h
//  160323-微博
//
//  Created by Jun on 16/4/7.
//  Copyright © 2016年 Jun. All rights reserved.
//
#define WJComposeToolBarHeight 44

#define numberOfButtonInComposeToolBar 5
#import <UIKit/UIKit.h>
typedef enum {
    WJComposeToolBarButtonTypeCamera,//📷
    WJComposeToolBarButtonTypePictrue,//相簿
    WJComposeToolBarButtonTypeMention,//@
    WJComposeToolBarButtonTypeTrend,//#
    WJComposeToolBarButtonTypeEmotion//😊
}WJComposeToolBarButtonType;
@interface WJComposeToolBar : UIView

@end
