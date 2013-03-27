//
//  ViewController.h
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-22.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"
#import "DYTextImageView.h"
#import "YBLHttpResponseDelegate.h"
#import "ASIHTTPRequest.h"

@interface ViewController : UIViewController <DYTextImageViewDelegate,PullingRefreshTableViewDelegate,YBLHttpResponseDelegate,UITableViewDataSource,UITableViewDelegate>
{
    long _lastItemTime;
}
@property BOOL refreshing;
@property (nonatomic) NSRange highlightedRange;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) PullingRefreshTableView *tableView;
@end
