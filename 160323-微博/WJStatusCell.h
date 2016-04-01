//
//  WJStatusCell.h
//  160323-微博
//
//  Created by Jun on 16/4/1.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJStatus;
@interface WJStatusCell : UITableViewCell

/**
 *  status模型
 */
@property (nonatomic, strong) WJStatus *status;

/**
 *  根据tableview得到缓存 返回cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
