//
//  DYinternalImageView.m
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-22.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FullScreenImageView;
@protocol FullScreenImageViewDelegate <NSObject>
- (void)fullScreenImageView:(FullScreenImageView *)imageView didLongPressedWithImage:(UIImage *)image;
@end


@interface FullScreenImageView : UIScrollView<UIScrollViewDelegate>
{
    UITapGestureRecognizer *_singleTap;
    UIActivityIndicatorView *_activityView;
    BOOL scaleFinish;
}

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak) id<FullScreenImageViewDelegate>myDelegate;
- (id)initWithImage:(UIImage *)image inFrame:(CGRect)frame withThumbnailImageFrame:(CGRect)cellImageFrame andOriginUrl:(NSURL *)url;
@end

