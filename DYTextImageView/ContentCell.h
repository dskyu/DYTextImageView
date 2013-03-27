//
//  ContentCell.h
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-24.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBLModel.h"
#import "DYTextImageView.h"
@interface ContentCell : UITableViewCell

@property (strong,nonatomic) YBLJob *job;
@property (strong,nonatomic) UIImageView *headImageView;
@property (strong,nonatomic) UILabel *nameLabel;
@property (strong,nonatomic) UILabel *timeLabel;
@property (strong,nonatomic) DYTextImageView *textImageView;

- (void)refreshData:(YBLJob *)job;

@end
