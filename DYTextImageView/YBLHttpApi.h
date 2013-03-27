//
//  YBLHttpApi.h
//  ybole
//
//  Created by Developer on 10/17/12.
//  Copyright (c) 2012 Ybole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTP/ASIHTTPRequest.h"
#import "YBLHttpResponseDelegate.h"
#import "YBLHttpRequest.h"


#define URL_DOMAIN                          @"www.ybole.com"

#define URL_API_SEARCH_ALLJOBS              @"/api/1/tweet/search"

typedef enum _YBLApiType {
    YBLApiSearchJobByName,
}YBLApiType;

@class YBLUser;
@class YBLHttpResponseListener;

@interface YBLHttpApi : NSObject
{
    YBLApiType _YBLApiType;
}

@property (strong, nonatomic) NSString *domain;
@property (strong, nonatomic) NSString *clientVersion;
@property (strong, nonatomic) NSString *httpProtocol;
@property (strong, nonatomic) YBLHttpResponseListener *responseListener;
@property (weak, nonatomic) id<YBLHttpResponseDelegate> responseDelegate;


- (void) searchJobsByName:(NSString *)query time:(NSInteger)time;
- (id) initWithDomain:(NSString *)domain clientVersion:(NSString *)version isHttps:(BOOL) https;

@end
