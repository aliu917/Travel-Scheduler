//
//  Schedule.h
//  Travel Scheduler
//
//  Created by gilemos on 7/19/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"

NS_ASSUME_NONNULL_BEGIN

@interface Schedule : NSObject

@property(strong, nonatomic)NSMutableArray *arrayOfAttractions;
@property(strong, nonatomic)NSMutableArray *morningAttractions;
@property(strong, nonatomic)NSMutableArray *afternoonAttractions;
@property(strong, nonatomic)NSMutableArray *eveningAttractions;
@property(strong, nonatomic)NSMutableArray *arrayOfRestaurants;
@property(strong, nonatomic)NSMutableArray *breakfastRestaurants;
@property(strong, nonatomic)NSMutableArray *lunchRestaurants;
@property(strong, nonatomic)NSMutableArray *dinnerRestaurants;
@property(strong, nonatomic)NSMutableDictionary *availabilityDictionary;
@property(strong, nonatomic)Place *home;
@property(nonatomic)int numberOfDays;
@property(strong, nonatomic)NSDate *startDate;
@property(strong, nonatomic)NSDate *endDate;

@end

NS_ASSUME_NONNULL_END
