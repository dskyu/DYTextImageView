//
//  YBLUser.h
//  ybole
//
//  Created by Developer on 10/19/12.
//  Copyright (c) 2012 Ybole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBLUser : NSObject

@property (strong, nonatomic) NSString *face;
@property (strong, nonatomic) NSString *nickname;


- (id) initWithDic:(NSDictionary *)dic;
@end
