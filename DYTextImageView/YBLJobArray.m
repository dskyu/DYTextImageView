//
//  YBLJobArray.m
//  ybole
//
//  Created by bunny on 12-11-9.
//  Copyright (c) 2012年 Ybole. All rights reserved.
//

#import "YBLJobArray.h"

@implementation YBLJobArray

- (id) initWithString:(NSString *)string
{
    
    if ((self = (YBLJobArray*)[NSMutableArray array])) {
        NSDictionary *dictionary = [string objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
        for (NSDictionary *dic in [dictionary objectForKey:@"content"]) {
            YBLJob *job = [[YBLJob alloc] initWithDic:dic];
            [self addObject:job];
        }
    }
    
    return self;
}

@end
