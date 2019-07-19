//
//  Hub.h
//  Travel Scheduler
//
//  Created by gilemos on 7/18/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

#import "Place.h"

NS_ASSUME_NONNULL_BEGIN

@interface Hub : Place
@property(strong, nonatomic)NSMutableArray *arrayOfNearbyPlaces;
@property(strong, nonatomic)NSMutableDictionary *dictionaryOfArrayOfPlaces;
@property(strong, nonatomic)NSMutableArray *arrayOfNearbyRestaurants;
@property(strong, nonatomic)NSMutableArray *arrayOfNearbyHotels;
@property(strong, nonatomic)NSMutableArray *arrayOfNearbyMuseums;
@property(strong, nonatomic)NSMutableArray *arrayOfNearbyAquariums;
@property(strong, nonatomic)NSMutableArray *arrayOfNearbyShoppings;
@property(strong, nonatomic)NSMutableArray *arrayOfNearbyMovies;
@property(strong, nonatomic)NSMutableArray *arrayOfNearbyParks;
@property(nonatomic)int numberOfCategories;
@property(nonatomic)bool hasAllArrays;

- (void)initHubWithName:(NSString *)name withCompletion:(void (^)(Hub *hub, NSError *error))completion;
- (instancetype)initHubWithPlace:(Place *)place;
-(void)setUpHubArrays;
- (void)makeArrayOfNearbyPlacesWithType:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
