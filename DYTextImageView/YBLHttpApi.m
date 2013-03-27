//
//  YBLHttpApi.m
//  ybole
//
//  Created by Developer on 10/17/12.
//  Copyright (c) 2012 Ybole. All rights reserved.
//

#import "YBLHttpApi.h"
#import "YBLHttpResponseListener.h"
#import "YBLModel.h"

@interface YBLHttpApi (private)
- (NSString *) getFullUrl:(NSString *) sub;
- (NSString *) generateUrlWithProtocol:(NSString *)protocol domain:(NSString *) domain sub:(NSString *)sub params:(NSDictionary *) params;
@end

@implementation YBLHttpApi
@synthesize domain = _domain;
@synthesize clientVersion = _clientVersion;
@synthesize httpProtocol = _httpProtocol;
@synthesize responseListener = _responseListener;
@synthesize responseDelegate = _responseDelegate;

- (id) initWithDomain:(NSString *)domain clientVersion:(NSString *)version isHttps:(BOOL) https
{
    if (self = [super init])
    {
        _domain = domain;
        _clientVersion = version;
        _httpProtocol = https ? @"https://" : @"http://";
        _responseListener = [YBLHttpResponseListener shareHttpResponseListener];
    }
    return self;
}

- (NSString *) getFullUrl:(NSString *) sub
{
    return [NSString stringWithFormat:@"%@%@%@",_httpProtocol,_domain,sub];
}


- (void) executeHttpRequest:(YBLHttpRequest *)request
{
    [request setTag:_YBLApiType];
    [request setNumberOfTimesToRetryOnTimeout:3];
    [request setTimeOutSeconds:65];
    [request setResponseDelegate:_responseDelegate];
    [request setDelegate:_responseListener];
    [request startAsynchronous];
}


- (void) searchJobsByName:(NSString *)query time:(NSInteger)time
{
    NSString *url = [self getFullUrl:URL_API_SEARCH_ALLJOBS];
    YBLHttpRequest *request = [YBLHttpRequest requestWithURL:[NSURL URLWithString:url]];
    _YBLApiType = YBLApiSearchJobByName;
    [request setPostValue:query forKey:@"query"];
    if (time != 0) {
        [request setPostValue:[NSString stringWithFormat:@"%d",time] forKey:@"time"];
    }
    [self executeHttpRequest:request];
}

@end
