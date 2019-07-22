//
//  Date.h
//  Travel Scheduler
//
//  Created by gilemos on 7/22/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface Date : NSObject

+ (float)getFormattedTimeFromString:(NSString *)timeString;
+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

@end

NS_ASSUME_NONNULL_END
