//
//  YBLHttpResponseListener.h
//  ybole
//
//  Created by bunny on 12-10-23.
//  Copyright (c) 2012年 Ybole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBLHttpResponseDelegate.h"
#import "YBLHttpRequest.h"
#import "YBLHttpApi.h"

@interface YBLHttpResponseListener : NSObject

+ (YBLHttpResponseListener *) shareHttpResponseListener;

@end
