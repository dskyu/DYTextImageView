//
//  DYLabel.m
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-23.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

#import "DYLabel.h"
#import "UILabel+fix.h"
#import <CoreText/CoreText.h>

@implementation DYLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitialiser];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInitialiser];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame attributedString:(NSAttributedString *)string;
{
    self = [self initWithFrame:frame];
    self.attributedText = [string mutableCopy];
    return self;
}

- (void)commonInitialiser
{
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)autoFitHeight
{
    CGSize size = CGSizeMake(300,[self.font lineHeight]*MaxNumberOfLines);
    CGSize labelsize = [self.text sizeWithFont:self.font constrainedToSize:size
                         lineBreakMode:UILineBreakModeTailTruncation];
    [self setFrame:CGRectMake(0,0, labelsize.width, labelsize.height)];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self autoFitHeight];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self autoFitHeight];
}


- (NSRange )keyRangeAtPoint:(CGPoint)point {
    
    NSMutableAttributedString* attrText = [self.attributedText mutableCopy];
    NSRange ZeroRange = NSMakeRange(NSNotFound, 0);

    if (!CGRectContainsPoint(self.bounds, point)) {
        return ZeroRange;
    }
    
    CGRect textRect = [self textRect];
    
    if (!CGRectContainsPoint(textRect, point)) {
        return ZeroRange;
    }
    
    NSRange range = ZeroRange;
    NSUInteger charindex = 0;
    while (charindex < [attrText length]) {
      
        id value = [attrText attribute:@"href" atIndex:charindex effectiveRange:&range];
        charindex = range.location+range.length;
        
        if (value) {
            
            CGRect rect1 = [self rectForLetterAtIndex:range.location];
            CGRect rect2 = [self rectForLetterAtIndex:range.location+range.length-1];
            
            if (rect2.origin.y != rect1.origin.y) {
                if (point.x > rect1.origin.x && point.y > rect1.origin.y && point.y < rect1.origin.y + rect1.size.height) {
                    break;
                }else if (point.x < rect2.origin.x && point.y > rect2.origin.y && point.y < rect2.origin.y + rect2.size.height)
                {
                    break;
                }
            }else{
                if (point.x > rect1.origin.x && point.x < rect2.origin.x + rect2.size.width && point.y > rect1.origin.y && point.y < rect1.origin.y + rect1.size.height) {
                    break;
                }
            }
            
        }
        range = ZeroRange;
    }
    return range;
   
}

#pragma mark --

- (CGRect)textRect {
    
    CGRect textRect = [self textRectForBounds:self.bounds limitedToNumberOfLines:self.numberOfLines];
    textRect.origin.y = (self.bounds.size.height - textRect.size.height)/2;
    
    if (self.textAlignment == NSTextAlignmentCenter) {
        textRect.origin.x = (self.bounds.size.width - textRect.size.width)/2;
    }
    if (self.textAlignment == NSTextAlignmentRight) {
        textRect.origin.x = self.bounds.size.width - textRect.size.width;
    }
    
    return textRect;
}


#pragma mark --

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    NSRange range = [self keyRangeAtPoint:[touch locationInView:self]];
    
    if ([self.delegate conformsToProtocol:@protocol(DYLabelDelegate)] && [self.delegate respondsToSelector:@selector(label:didBeginTouch:onKeyInRange:)]) {
        [self.delegate label:self didBeginTouch:touch onKeyInRange:range];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    NSRange range = [self keyRangeAtPoint:[touch locationInView:self]];
    if ([self.delegate conformsToProtocol:@protocol(DYLabelDelegate)] && [self.delegate respondsToSelector:@selector(label:didMoveTouch:onKeyInRange:)]) {
        [self.delegate label:self didMoveTouch:touch onKeyInRange:range];
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    NSRange range = [self keyRangeAtPoint:[touch locationInView:self]];
    if ([self.delegate conformsToProtocol:@protocol(DYLabelDelegate)] && [self.delegate respondsToSelector:@selector(label:didEndTouch:onKeyInRange:)]) {
        [self.delegate label:self didEndTouch:touch onKeyInRange:range];
    }
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    if ([self.delegate conformsToProtocol:@protocol(DYLabelDelegate)] && [self.delegate respondsToSelector:@selector(label:didCancelTouch:)]) {
        [self.delegate label:self didCancelTouch:touch];
    }

    [super touchesCancelled:touches withEvent:event];
}

@end
