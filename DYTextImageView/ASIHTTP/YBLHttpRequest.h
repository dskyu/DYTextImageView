//
//  YBLHttpRequest.h
//  ybole
//
//  Created by bunny on 12-11-9.
//  Copyright (c) 2012年 Ybole. All rights reserved.
//

#import "ASIFormDataRequest.h"
#import "YBLHttpResponseDelegate.h"
@interface YBLHttpRequest : ASIFormDataRequest

@property (strong, nonatomic) id<YBLHttpResponseDelegate> responseDelegate;

@end
