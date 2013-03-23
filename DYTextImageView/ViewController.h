//
//  ViewController.h
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-22.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYTextImageView.h"

@interface ViewController : UIViewController <DYTextImageViewDelegate>

@property (nonatomic,strong) DYTextImageView *textImageView;
@property(nonatomic) NSRange highlightedRange;
@end
