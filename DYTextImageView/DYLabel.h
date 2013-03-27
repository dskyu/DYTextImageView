//
//  DYLabel.h
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-23.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MaxNumberOfLines   5

@class DYLabel;

@protocol DYLabelDelegate <NSObject>

- (void)label:(DYLabel*)label didBeginTouch:(UITouch*)touch onKeyInRange:(NSRange)range;
- (void)label:(DYLabel*)label didMoveTouch:(UITouch*)touch onKeyInRange:(NSRange)range;
- (void)label:(DYLabel*)label didEndTouch:(UITouch*)touch onKeyInRange:(NSRange)range;
- (void)label:(DYLabel*)label didCancelTouch:(UITouch*)touch;

@end
@interface DYLabel : UILabel

@property(nonatomic, weak) id <DYLabelDelegate> delegate;

- (void)autoFitHeight;
- (id)initWithFrame:(CGRect)frame attributedString:(NSAttributedString *)string;

@end
