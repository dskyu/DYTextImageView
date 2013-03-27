//
//  YBLJob.h
//  ybole
//
//  Created by bunny on 12-11-9.
//  Copyright (c) 2012年 Ybole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBLUser.h"

@interface YBLJob : NSObject

@property (strong, nonatomic) NSString *thumbnail;
@property (strong, nonatomic) NSString *origpic;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *jobid;
@property (strong, nonatomic) NSString *source;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) YBLUser *user;

- (id) initWithDic:(NSDictionary *)dic;

@end
