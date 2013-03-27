//
//  YBLJob.m
//  ybole
//
//  Created by bunny on 12-11-9.
//  Copyright (c) 2012年 Ybole. All rights reserved.
//

#import "YBLJob.h"

@implementation YBLJob
@synthesize content;
@synthesize jobid;
@synthesize source;
@synthesize time;
@synthesize url;
@synthesize user;
@synthesize thumbnail;
@synthesize origpic;

- (id) initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.content = [dic objectForKey:@"content"];
        self.jobid = [dic objectForKey:@"id"];
        self.source = [dic objectForKey:@"source"];
        self.time = [[dic objectForKey:@"time"] stringValue];
        self.url = [dic objectForKey:@"url"];
        self.origpic = [dic objectForKey:@"origpic"];
        self.thumbnail = [dic objectForKey:@"thumbnail"];
        self.user = [[YBLUser alloc] initWithDic:[dic objectForKey:@"user"]];
    }
    return self;
}

@end
