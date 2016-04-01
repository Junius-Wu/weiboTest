//
//  WJStatus.h
//  160323-微博
//
//  Created by Jun on 16/3/29.
//  Copyright © 2016年 Jun. All rights reserved.
//

// 昵称字体
#define WJstatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define WJStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define WJStatusCellSourceFont HWStatusCellTimeFont
// 正文字体
#define WJStatusCellContentFont [UIFont systemFontOfSize:14]

#import <Foundation/Foundation.h>
@class WJUser;

@interface WJStatus : NSObject
/**
 *  字符串类型的微博id
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  微博主要内容 文字
 */
@property (nonatomic, copy) NSString *text;

/**
 *  用户模型
 */
@property (nonatomic, strong) WJUser *user;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  配图数组 
 */
@property (nonatomic, copy) NSArray *pic_urls;

- (void)setSubViewsFrame;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
