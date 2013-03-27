//
//  DYinternalImageView.m
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-22.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

#import "FullScreenImageView.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
static CGRect _cellImageFrame;

@interface FullScreenImageView()

@end

@implementation FullScreenImageView
- (id)initWithFrame:(CGRect)frame
{
    return [self initWithImage:nil inFrame:frame withThumbnailImageFrame:CGRectZero andOriginUrl:nil];
}


- (id)initWithImage:(UIImage *)image inFrame:(CGRect)frame withThumbnailImageFrame:(CGRect)cellImageFrame andOriginUrl:(NSURL *)url
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUserInteractionEnabled:YES];
        [self setBackgroundColor:[UIColor blackColor]];
        [self setAutoresizesSubviews:YES];
        scaleFinish = NO;
        _imageView = [[UIImageView alloc] initWithImage:image];
        
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTap setNumberOfTapsRequired:2];
        
        [self addGestureRecognizer:_singleTap];
        [self addGestureRecognizer:doubleTap];
        
        UIGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPress];
        [self addSubview:_imageView];
       
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:_activityView];
        [_activityView setBackgroundColor:[UIColor blackColor]];
        [_activityView setFrame:CGRectMake((frame.size.width-20)/2, (frame.size.height-20)/2, 20, 20)];
        
        
        
        _cellImageFrame = cellImageFrame;
        _imageView.frame = cellImageFrame;
        float minimumScale = [self frame].size.width  / image.size.width;
        if (minimumScale<1) {
            CGRect destinationFrame = CGRectMake(0, frame.size.height/2 - minimumScale*image.size.height/2 , frame.size.width, minimumScale*image.size.height);
            self.delegate = self;
            
            _singleTap.enabled = NO;
            [UIView animateWithDuration:0.5 animations:^{
                _imageView.frame = destinationFrame;
            } completion:^(BOOL finished){
                _singleTap.enabled = YES;
                
                if (url) {
                    [_activityView startAnimating];
                    [self scaleToOriginFull:image url:url frame:frame];
                }else{
                    CGFloat width = image.size.width;
                    CGFloat height = image.size.height;
                    
                    _imageView.frame = CGRectMake(0, 0, width, height);
                    [self setMinimumZoomScale:minimumScale];
                    [self setZoomScale:minimumScale];
                    _imageView.center = self.center;
                }
            }];
        } else {
            CGRect destinationFrame = CGRectMake(frame.size.width/2-image.size.width/2, frame.size.height/2 - image.size.height/2 , image.size.width, image.size.height);
            self.delegate = self;
            
            _singleTap.enabled = NO;
            [UIView animateWithDuration:0.5 animations:^{
                _imageView.frame = destinationFrame;
            } completion:^(BOOL finished){
                _singleTap.enabled = YES;
                
                if (url) {
                    [_activityView startAnimating];
                    [self scaleToOriginFull:image url:url frame:frame];
                }else{
                    CGFloat width = image.size.width;
                    CGFloat height = image.size.height;
                    while (width<=frame.size.width) {
                        width *= 10;
                        height *= 10;
                    }
                    _imageView.frame = CGRectMake(0, 0, width, height);
                    float minimumScale = image.size.width  / width;
                    [self setMinimumZoomScale:minimumScale];
                    [self setZoomScale:minimumScale];
                    _imageView.center = self.center;
                }

            }];
        }
    }
    return self;

}

- (void)logCGRECT:(CGRect) r
{
    NSLog(@"%f %f %f %f",r.origin.x,r.origin.y,r.size.width,r.size.height);
}

- (void)scaleToOriginFull:(UIImage *)image url:(NSURL *)url frame:(CGRect) frame
{
    NSLog(@"thumbnail %f %f",image.size.width,image.size.height);
    __block FullScreenImageView *blockSelf = self;
    [_imageView setImageWithURL:url placeholderImage:image success:^(UIImage *image, BOOL cached) {
        NSLog(@"orig %f %f",image.size.width,image.size.height);
        if (cached) {
            NSLog(@"is cached");
        }else{
            NSLog(@"isn't cached");
        }
        [blockSelf->_activityView stopAnimating];
        
        float minimumScale = blockSelf.frame.size.width  / image.size.width;
        if (minimumScale<1) {
            CGRect destinationFrame = CGRectMake(0, blockSelf.frame.size.height/2 - minimumScale*image.size.height/2 , blockSelf.frame.size.width, minimumScale*image.size.height);
          
            blockSelf->_singleTap.enabled = NO;
            [UIView animateWithDuration:0.5 animations:^{
                blockSelf->_imageView.frame = destinationFrame;
            } completion:^(BOOL finished){
                blockSelf->_singleTap.enabled = YES;
                CGFloat width = image.size.width;
                CGFloat height = image.size.height;
                
                blockSelf.imageView.frame = CGRectMake(0, 0, width, height);
                [blockSelf setMinimumZoomScale:minimumScale];
                [blockSelf setZoomScale:minimumScale];
        //        blockSelf.imageView.center = blockSelf.center;
                
            }];
        } else {
            CGRect destinationFrame = CGRectMake(frame.size.width/2-image.size.width/2, frame.size.height/2 - image.size.height/2 , image.size.width, image.size.height);
         
            
            blockSelf->_singleTap.enabled = NO;
            [UIView animateWithDuration:0.5 animations:^{
                blockSelf.imageView.frame = destinationFrame;
            } completion:^(BOOL finished){
                blockSelf->_singleTap.enabled = YES;
                CGFloat width = image.size.width;
                CGFloat height = image.size.height;
                while (width<=frame.size.width) {
                    width *= 10;
                    height *= 10;
                }
                blockSelf.imageView.frame = CGRectMake(0, 0, width, height);
                float minimumScale = image.size.width  / width;
                [blockSelf setMinimumZoomScale:minimumScale];
                [blockSelf setZoomScale:minimumScale];
                blockSelf.imageView.center = blockSelf.center;
                
                
            }];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //这里采取的方案是， 在进行缩放是，如果有黑边则进行小的调整使其居中
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width)*0.5:0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height)*0.5:0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width*0.5 + offsetX, scrollView.contentSize.height*0.5 + offsetY);

}
#pragma mark - gestures
- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {

    self.backgroundColor = [UIColor clearColor];

    [self setZoomScale:self.minimumZoomScale];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            self.imageView.frame = _cellImageFrame;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
    }];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    
}

- (void)longPress:(UIGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self.myDelegate fullScreenImageView:self didLongPressedWithImage:self.imageView.image];
    }
}
@end
