//
//  ViewController.m
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-22.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

#import "ViewController.h"
#import "DYTextImageView.h"
#import <CoreText/CoreText.h>
#import "UILabel+fix.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize textImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	

    textImageView = [[DYTextImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    [self.view addSubview:textImageView];
    textImageView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textImageView:(DYTextImageView*)textImageView textDidBeginTouch:(UITouch*)touch onKeyInRange:(NSRange)range
{
    [self highlightWordContainingRange:range];
}

- (void)textImageView:(DYTextImageView*)textImageView textDidMoveTouch:(UITouch*)touch onKeyInRange:(NSRange)range
{
    [self highlightWordContainingRange:range];
}
- (void)textImageView:(DYTextImageView*)textImageView textDidEndTouch:(UITouch*)touch onKeyInRange:(NSRange)range
{
    [self removeHighlight];
}
- (void)textImageView:(DYTextImageView*)textImageView textDidCancelTouch:(UITouch*)touch
{
    [self removeHighlight];
}


#pragma mark --

- (void)highlightWordContainingRange:(NSRange)range {
    
    NSRange zeroRange = NSMakeRange(0, 0);
    
    if (NSEqualRanges(range, zeroRange)) {
        
        //user did nat click on any word
        [self removeHighlight];
        return;
    }
    

    if (NSEqualRanges(range, self.highlightedRange)) {
        return; //this word is already highlighted
    }
    else {
        [self removeHighlight]; //remove highlight on previously selected word
    }
    
    self.highlightedRange = range;
    
    //highlight selected word
    NSMutableAttributedString* attributedString = [self.textImageView.label.attributedText mutableCopy];
    [attributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:range];
    self.textImageView.label.attributedText = attributedString;
}

- (void)removeHighlight {
    
    if (self.highlightedRange.location != NSNotFound) {
        
        //remove highlight from previously selected word
        NSMutableAttributedString* attributedString = [self.textImageView.label.attributedText mutableCopy];
        [attributedString removeAttribute:NSBackgroundColorAttributeName range:self.highlightedRange];
        self.textImageView.label.attributedText = attributedString;
        
        self.highlightedRange = NSMakeRange(NSNotFound, 0);
    }
}



@end
