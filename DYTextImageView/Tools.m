//
//  Tools.m
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-24.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (NSString *) transTimeSp:(NSString *) time
{
    NSDate *datenow = [NSDate date];
    NSInteger duration = (NSInteger)[datenow timeIntervalSince1970] - [time integerValue];
    NSString *str;
    
    int second = 1;
    int minute = second * 60;
    int hour = minute * 60;
    int day = hour * 24;
    
    if (duration < second * 7) {
        str = NSLocalizedString(@"刚刚发布", @"rightnow");
    }else if (duration < minute) {
        int n = (int)duration/second;
        str = [NSString stringWithFormat:NSLocalizedString(@"%d秒钟前", @"second before"),n];
    }else if (duration < hour) {
        int n = (int)duration/minute;
        str = [NSString stringWithFormat:NSLocalizedString(@"%d分钟前", @"minute before"),n];
    }else if (duration < day) {
        int n = (int)duration/hour;
        str = [NSString stringWithFormat:NSLocalizedString(@"%d小时前", @"hour before"),n];
    }else if (duration > day && duration < day * 2) {
        str = NSLocalizedString(@"昨天", @"day yestoday");
    }else if (duration > day && duration < day * 3) {
        str = NSLocalizedString(@"前天", @"day the day before yestoday");
    }else if (duration < day * 7) {
        int n = (int)duration/day;
        str = [NSString stringWithFormat:NSLocalizedString(@"%d天前", @"day before"),n];
    }else{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSLocale *chLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CH"];
        [formatter setLocale:chLocale];
        [formatter setDateFormat:NSLocalizedString(@"MM月dd日 hh:mm", @"date formatter")];
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-duration];
        str = [formatter stringFromDate:date];
    }
    
    return str;
}


@end
