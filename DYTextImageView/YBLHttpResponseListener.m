//
//  YBLHttpResponseListener.m
//  ybole
//
//  Created by bunny on 12-10-23.
//  Copyright (c) 2012年 Ybole. All rights reserved.
//


#import "YBLHttpResponseListener.h"
//#import "YBLException.h"
#import "YBLConstant.h"
#import "YBLModel.h"

static YBLHttpResponseListener *_responseListener = nil;

@implementation YBLHttpResponseListener


+ (YBLHttpResponseListener *) shareHttpResponseListener  
{
    if (_responseListener == nil) {
        _responseListener = [[YBLHttpResponseListener alloc] init];
    }
    return _responseListener;
}

- (NSString *) getReturnValue:(ASIHTTPRequest *) request
{
 //   [self checkRequest:request];

    NSDictionary *dic = [[request responseString] objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    
    NSInteger error = [[dic objectForKey:@"ret"] integerValue];
    
    if (error == ERROR_OK) {
        if ([dic objectForKey:@"val"] == [NSNull null]) {
            return @"ok";
        }else{
            return [[dic objectForKey:@"val"] JSONString];
        }
    }else{
            // handle errors
    }
    
    return @"ok";
}

#pragma mark -
#pragma mark ASIHttpRequestDelegate

- (void)requestStart:(ASIHTTPRequest *)request
{
    
}

- (void)requestFinished:(YBLHttpRequest *)request
{

    @try {
        
        NSString *responseString = [self getReturnValue:request];
    
        id delegate = request.responseDelegate;
        
        switch ([request tag]) {
            case YBLApiSearchJobByName: //search_weibo_jobs
            {
                if ([delegate conformsToProtocol:@protocol(YBLHttpResponseDelegate)] && [delegate respondsToSelector:@selector(weiboSearchJobsRecevied:)]) {
                    YBLJobArray *array = [[YBLJobArray alloc] initWithString:responseString];
                    [delegate weiboSearchJobsRecevied:array];
                }
                
                break;
            }
            default:
                break;
        }
    }
    @catch (id exception) {
        //[exception showWithLoadStatus:YES andHandle:request];
    }
    @finally {
        
    }
    
}

- (void)requestFailed:(YBLHttpRequest *)request
{
    // NSLog(@"fail %d",[request responseStatusCode]);
//    @try {
//        [[NSNotificationCenter defaultCenter] postNotificationName:TimeoutNotification object:nil];
//        [self checkRequest:request];
//        [YBLWeibo showToastWithText:NSLocalizedString(@"不好意思，加载出错，请稍后重试", @"load failure")];
//    }
//    @catch (id exception) {
//        NSLog(@"%@",[ASIHTTPRequest sessionCookies]);
//        [exception showWithLoadStatus:YES andHandle:request];
//    }
//    @finally {
//        
//    }
}


@end
