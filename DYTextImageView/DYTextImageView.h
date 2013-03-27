//
//  DYTextImageView.h
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-21.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

// 2013.3.21

#import <UIKit/UIKit.h>
#import "DYLabel.h"
#import "DYinternalImageView.h"
#import "FullScreenImageView.h"

@class DYTextImageView;

@protocol DYTextImageViewDelegate <NSObject>

- (void)textImageView:(DYTextImageView*)textImageView textDidBeginTouch:(UITouch*)touch onKeyInRange:(NSRange)range;
- (void)textImageView:(DYTextImageView*)textImageView textDidMoveTouch:(UITouch*)touch onKeyInRange:(NSRange)range;
- (void)textImageView:(DYTextImageView*)textImageView textDidEndTouch:(UITouch*)touch onKeyInRange:(NSRange)range;
- (void)textImageView:(DYTextImageView*)textImageView textDidCancelTouch:(UITouch*)touch;

@optional
- (void)textImageView:(DYTextImageView *)textImageView imageDidTouchedInside:(UIImageView *)imageView;

@end


@interface DYTextImageView : UIView <DYLabelDelegate>

@property (nonatomic,weak) id <DYTextImageViewDelegate> delegate;

@property (readwrite) NSUInteger maxNumberOfLines;
@property (nonatomic,strong) DYLabel *label;
// 实现多张图片排列
// @property (nonatomic,strong) NSArray *imageViewArray;

@property (nonatomic,strong) DYinternalImageView *imageView;
@end
