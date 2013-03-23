//
//  DYTextImageView.h
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-21.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

// Base on HPGrowingTextView

// 2013.3.21

#import <UIKit/UIKit.h>
#import "DYLabel.h"

@class DYinternalImageView;
@class DYTextImageView;

@protocol DYTextImageViewDelegate <NSObject>

- (void)textImageView:(DYTextImageView*)textImageView textDidBeginTouch:(UITouch*)touch onKeyInRange:(NSRange)range;
- (void)textImageView:(DYTextImageView*)textImageView textDidMoveTouch:(UITouch*)touch onKeyInRange:(NSRange)range;
- (void)textImageView:(DYTextImageView*)textImageView textDidEndTouch:(UITouch*)touch onKeyInRange:(NSRange)range;
- (void)textImageView:(DYTextImageView*)textImageView textDidCancelTouch:(UITouch*)touch;

@end


@interface DYTextImageView : UIView <DYLabelDelegate>
{
    NSArray *internalImageViewArray;
}
@property (nonatomic,weak) id <DYTextImageViewDelegate> delegate;

@property (readwrite) NSUInteger maxNumberOfLines;
@property (nonatomic,strong) DYLabel *label;
@property (nonatomic,strong) NSArray *imageViewArray;




@end
