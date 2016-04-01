//
//  WJStatus.m
//  160323-微博
//
//  Created by Jun on 16/3/29.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJStatus.h"
#import "MJExtension.h"
#import "WJUser.h"
// cell的边框宽度
#define WJStatusCellBorderW 10
#define WJStatusCellVipW 14
#define WJStatusCellIconWH 35
@implementation WJStatus

- (NSDictionary *)objectClassInArray {
    return @{@"pic_ids" : [NSString class]};
}
///** 原创微博整体 */
//@property (nonatomic, assign) CGRect originalViewF;
///** 头像 */
//@property (nonatomic, assign) CGRect iconViewF;
///** 会员图标 */
//@property (nonatomic, assign) CGRect vipViewF;
///** 配图 */
//@property (nonatomic, assign) CGRect photoViewF;
///** 昵称 */
//@property (nonatomic, assign) CGRect nameLabelF;
///** 时间 */
//@property (nonatomic, assign) CGRect timeLabelF;
///** 来源 */
//@property (nonatomic, assign) CGRect sourceLabelF;
///** 正文 */
//@property (nonatomic, assign) CGRect contentLabelF;
//
///** cell的高度 */
//@property (nonatomic, assign) CGFloat cellHeight;


- (void)setSubViewsFrame {
    //设置所有frame、
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    //头像
    CGFloat iconX = WJStatusCellBorderW;
    CGFloat iconY = WJStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, WJStatusCellIconWH, WJStatusCellIconWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + WJStatusCellBorderW;
    CGFloat nameY = self.iconViewF.origin.y;
    CGSize nameSize = [self sizeWithText:self.user.name font:WJstatusCellNameFont
                                 maxSize:CGSizeMake(screenSize.width - WJStatusCellIconWH - WJStatusCellVipW - 4 * WJStatusCellBorderW, MAXFLOAT)];

    self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
#warning Unknow
    //VIP 未知属性？？？？
    
    //时间  screenSize.width - WJStatusCellIconWH - 3 * WJStatusCellBorderW
    CGFloat timeX = nameX;
    CGFloat timeY = nameY + nameSize.height + 3;
   
    CGSize timeSize = [self sizeWithText:self.text font:WJStatusCellTimeFont
                                 maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        self.timeLabelF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    //正文
    CGFloat contentX = iconX;
    CGFloat contentY = WJStatusCellBorderW * 2 + WJStatusCellIconWH;
    CGSize contentSize = [self sizeWithText:self.text font:WJStatusCellContentFont maxSize:CGSizeMake(screenSize.width - 2 * WJStatusCellBorderW, MAXFLOAT)];
    WJLog(@"-------size-------%f, %f", contentSize.width    ,contentSize.height);
    self.contentLabelF = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    
    
    
    self.originalViewF = CGRectMake(0, 0, 320 , 320);
    self.cellHeight = 320;
    
}

//要计算的text
//字体为[UIFont systemFontOfSize:大小]/label.font
//maxSize为限制宽高的大小
-(CGSize) sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    //存放字体的大小的字典
    NSDictionary *attrs = @{NSFontAttributeName: font};
    
    return [text boundingRectWithSize:maxSize                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attrs
                              context:nil
            ].size;
}
@end

