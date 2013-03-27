//
//  ContentCell.m
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-24.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

#import "ContentCell.h"
#import "UIImageView+WebCache.h"
#import "Tools.h"

@implementation ContentCell
@synthesize job = _job;
@synthesize headImageView = _headImageView;
@synthesize nameLabel = _nameLabel;
@synthesize timeLabel = _timeLabel;
@synthesize textImageView = _textImageView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self addSubview:_headImageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 20)];
        [_nameLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self addSubview:_nameLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 200, 20)];
        [_timeLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self addSubview:_timeLabel];
        
        _textImageView = [[DYTextImageView alloc] initWithFrame:CGRectMake(10, 60, 300, 21*MaxNumberOfLines)];
        [self addSubview:_textImageView];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

- (void)refreshData:(YBLJob *)job
{
    [_headImageView setImageWithURL:[NSURL URLWithString:job.user.face] placeholderImage:[UIImage imageNamed:@"defaulthead.png"]];
    [_nameLabel setText:job.user.nickname];
    [_timeLabel setText:[Tools transTimeSp:job.time]];
    
    
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@说 %@",job.user.nickname,job.content]];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, [job.user.nickname length])];
    [attrString addAttribute:@"href" value:@"to do something" range:NSMakeRange(0, [job.user.nickname length])];

    [_textImageView.label setAttributedText:attrString];
    
    CGRect frame = _textImageView.label.frame;
    
    _textImageView.imageView.hidden = YES;
       
    if (job.thumbnail) {
        [_textImageView.imageView setFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height + 20, 100, 100)];
        _textImageView.imageView.hidden = NO;
        frame.size.height += 120;
        
        __block ContentCell *blockSelf = self;
        [_textImageView.imageView setImageWithURL:[NSURL URLWithString:job.thumbnail] placeholderImage:[UIImage imageNamed:@"loading_bg.png"] success:^(UIImage *image, BOOL cached) {
            
            CGRect imageViewRect = blockSelf.textImageView.imageView.frame;
            CGFloat imageHeight = image.size.height;
            CGFloat imageWidth = image.size.width;
            CGFloat rate = imageHeight/imageWidth;
            
            if (rate > 1) {
                imageViewRect.size.width = 100/rate;
            }else{
                imageViewRect.size.width = 100/rate;
                if (imageViewRect.size.width > 300) {
                    imageViewRect.size.width = 300;
                }
            }
            blockSelf.textImageView.imageView.frame = imageViewRect;
            
        } failure:^(NSError *error) {
            
        }];
        
        [_textImageView.imageView setOripicUrl:job.origpic];
    }
    
    CGRect newFrame = _textImageView.frame;
    [_textImageView setFrame:CGRectMake(newFrame.origin.x,newFrame.origin.y,newFrame.size.width,frame.size.height)];
}



@end
