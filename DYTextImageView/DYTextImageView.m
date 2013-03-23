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
@synthesize imageViewArray = _imageViewArray;
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
      //  [self commonInitialiser];
    }
    return self;
}


-(void)commonInitialiser
{
    CGRect r = self.frame;
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:@"小明说 fjdlsafjdlfjdklsajflkds fdsafdsafdsa fd sa fd saf dsa fd saf sa fsda ajflkdsjafkldjsaklf jdlsk fasfdsafdsafd sfw ef ewq fq ferw gew erqafjasafj a 小江"];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [attrString addAttribute:@"href" value:@"to do something" range:NSMakeRange(0, 2)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10, 2)];
    [attrString addAttribute:@"href" value:@"to do something" range:NSMakeRange(10, 2)];
    
    
    _label = [[DYLabel alloc] initWithFrame:r attributedString:attrString];
    _label.delegate = self;
    [self addSubview:_label];
    

}




#pragma mark -
#pragma DYLabel Delegate 

- (void)label:(DYLabel*)label didBeginTouch:(UITouch*)touch onKeyInRange:(NSRange)range
{
    [self.delegate textImageView:self textDidBeginTouch:touch onKeyInRange:range];
}
- (void)label:(DYLabel*)label didMoveTouch:(UITouch*)touch onKeyInRange:(NSRange)range
{
    [self.delegate textImageView:self textDidMoveTouch:touch onKeyInRange:range];
}
- (void)label:(DYLabel*)label didEndTouch:(UITouch*)touch onKeyInRange:(NSRange)range
{
    [self.delegate textImageView:self textDidEndTouch:touch onKeyInRange:range];
}
- (void)label:(DYLabel*)label didCancelTouch:(UITouch*)touch
{
    [self.delegate textImageView:self textDidCancelTouch:touch];
}



@end
