//
//  YBLUser.m
//  ybole
//
//  Created by Developer on 10/19/12.
//  Copyright (c) 2012 Ybole. All rights reserved.
//


#import "YBLUser.h"

@implementation YBLUser

@synthesize face;
@synthesize nickname;

- (id) initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.face = (NSString *)[dic objectForKey:@"face"];
        self.nickname = (NSString *)[dic objectForKey:@"nickname"];
      
    }
    return self;
    
}

@end
