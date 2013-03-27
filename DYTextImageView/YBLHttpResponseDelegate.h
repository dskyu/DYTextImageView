//
//  YBLHttpResponseDelegate.h
//  ybole
//
//  Created by Developer on 11/5/12.
//  Copyright (c) 2012 Ybole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBLModel.h"
@protocol YBLHttpResponseDelegate <NSObject>

@optional

- (void)weiboSearchJobsRecevied:(YBLJobArray *)jobs;

@end
