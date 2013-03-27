//
//  DYTextImageView.m
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-21.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

#import "DYTextImageView.h"
#import <CoreText/CoreText.h>


@implementation DYTextImageView
@synthesize label = _label;
//@synthesize imageViewArray = _imageViewArray;
@synthesize imageView = _imageView;
@synthesize maxNumberOfLines= _maxNumberOfLines;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self commonInitialiser];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInitialiser];
    }
    return self;
}


-(void)commonInitialiser
{
    _label = [[DYLabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [_label setNumberOfLines:0];
    [_label setFont:[UIFont fontWithName:@"Arial" size:14]];
    [_label setLineBreakMode:UILineBreakModeTailTruncation];
    _label.delegate = self;
    [self addSubview:_label];
    
    
    _imageView = [[DYinternalImageView alloc] init];
    _imageView.hidden = YES;
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTouched)];
    [_imageView addGestureRecognizer:gesture];
    [self addSubview:_imageView];
}

- (void)imageViewTouched
{
    if ([self.delegate conformsToProtocol:@protocol(DYTextImageViewDelegate)] && [self.delegate respondsToSelector:@selector(textImageView:imageDidTouchedInside:)]) {
        [self.delegate textImageView:self imageDidTouchedInside:self.imageView];
    }
}


#pragma mark -
#pragma DYLabel Delegate 

- (void)label:(DYLabel*)label didBeginTouch:(UITouch*)touch onKeyInRange:(NSRange)range
{
    if ([self.delegate conformsToProtocol:@protocol(DYTextImageViewDelegate)] && [self.delegate respondsToSelector:@selector(textImageView:textDidBeginTouch:onKeyInRange:)]) {
        [self.delegate textImageView:self textDidBeginTouch:touch onKeyInRange:range];
    }
}
- (void)label:(DYLabel*)label didMoveTouch:(UITouch*)touch onKeyInRange:(NSRange)range
{
    if ([self.delegate conformsToProtocol:@protocol(DYTextImageViewDelegate)] && [self.delegate respondsToSelector:@selector(textImageView:textDidMoveTouch:onKeyInRange:)]) {
        [self.delegate textImageView:self textDidMoveTouch:touch onKeyInRange:range];
    }
    
}
- (void)label:(DYLabel*)label didEndTouch:(UITouch*)touch onKeyInRange:(NSRange)range
{
    if ([self.delegate conformsToProtocol:@protocol(DYTextImageViewDelegate)] && [self.delegate respondsToSelector:@selector(textImageView:textDidEndTouch:onKeyInRange:)]) {
        [self.delegate textImageView:self textDidEndTouch:touch onKeyInRange:range];
    }
    
}
- (void)label:(DYLabel*)label didCancelTouch:(UITouch*)touch
{
    if ([self.delegate conformsToProtocol:@protocol(DYTextImageViewDelegate)] && [self.delegate respondsToSelector:@selector(textImageView:textDidCancelTouch:)]) {
        [self.delegate textImageView:self textDidCancelTouch:touch];
    }
    
}



@end
