//
//  WJStatusCell.m
//  160323-微博
//
//  Created by Jun on 16/4/1.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJStatusCell.h"
#import "WJStatus.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "WJUser.h"
@interface WJStatusCell()\
/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation WJStatusCell
/**
 *  从缓存中取得cell、
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"status";
    WJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WJStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(void)setStatus:(WJStatus *)status {
    _status = status;
    [status setSubViewsFrame];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.originalView.frame = self.status.originalViewF;

    //头像
    self.iconView.frame = self.status.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.status.user.profile_image_url]  placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    //昵称
    self.nameLabel.frame = self.status.nameLabelF;
    self.nameLabel.text = self.status.user.name;
    //vip
#warning Unknow
    self.vipView.frame = self.status.vipViewF;
    //创建时间
    self.timeLabel.frame = self.status.timeLabelF;
    self.timeLabel.text = self.status.created_at;
    //文字内容
    self.contentLabel.frame = self.status.contentLabelF;
    self.contentLabel.text = self.status.text;
    //图片内容
    self.photoView.frame = self.status.photoViewF;
    //[self.photoView sd_setImageWithURL:[NSURL URLWithString:self.status.pic_urls[0][@"thumbnail_pic"]] placeholderImage:nil];
    
}

/**
 *  添加子控件
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加原创
        UIView *originalView = [[UIView alloc] init];
        self.originalView = originalView;
        [self.originalView setBackgroundColor:[UIColor greenColor]];
        [self.contentView addSubview:originalView];
        //头像
        UIImageView *iconView = [[UIImageView alloc] init];
        self.iconView = iconView;
        [self.originalView addSubview:iconView];
        //昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        self.nameLabel = nameLabel;
        self.nameLabel.font = WJstatusCellNameFont;
        [self.originalView addSubview:nameLabel];
        //vip
        UIImageView *vipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_membership"]];
        self.vipView = vipView;
        [self.originalView addSubview:vipView];
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        self.timeLabel = timeLabel;
        self.timeLabel.font = WJStatusCellTimeFont;
        [self.originalView addSubview:timeLabel];
        //正文
        UILabel *contentLabel = [[UILabel alloc] init];
        self.contentLabel = contentLabel;
        self.contentLabel.font = WJStatusCellContentFont;
        self.contentLabel.numberOfLines = 0;
        [self.originalView addSubview:contentLabel];
        //配图
        UIImageView *photoView = [[UIImageView alloc] init];
        self.photoView = photoView;
        [self.originalView addSubview:photoView];
        
    }
    return  self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
