//
//  Place.m
//  Travel Scheduler
//
//  Created by gilemos on 7/16/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

#import "Place.h"
#import "APIManager.h"
#import "Date.h"
#import "TravelSchedulerHelper.h"
@import GooglePlaces;

@implementation Place {
    GMSPlacesClient *_placesClient;
    bool _gotPlacesClient;
}

#pragma mark - Initialization methods
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    //dispatch_async(dispatch_get_main_queue(), ^{
//        [self getPlacesClient];
//        if(self) {
//            [self createAllProperties];
//            self.name = dictionary[@"name"];
//            self.address = dictionary[@"formatted_address"];
//            self.coordinates = dictionary[@"geometry"][@"location"];
//            self.iconUrl = dictionary[@"icon"];
//            self.placeId = dictionary[@"place_id"];
//            self.rating = dictionary[@"rating"];
//            self.photos = dictionary[@"photos"];
//            self.types = dictionary[@"types"];
//            [self setPlaceSpecificType];
//            self.unformattedTimes = dictionary[@"opening_hours"];
//            self.locked = NO;
//            self.isHome = NO;
//            self.scheduledTimeBlock = -1;
//            self.timeToSpend = -1;
//            self.hasAlreadyGone = NO;
//            self.isSelected = NO;
//            self.arrivalTime = -1;
//            self.departureTime = -1;
//            self.travelTimeToPlace = -1;
//            self.travelTimeFromPlace = -1;
//            [self makeScheduleDictionaries];
//        }
//    });
    [self createAllProperties];
    self.name = dictionary[@"name"];
    self.address = dictionary[@"formatted_address"];
    self.coordinates = dictionary[@"geometry"][@"location"];
    self.iconUrl = dictionary[@"icon"];
    self.placeId = dictionary[@"place_id"];
    self.rating = dictionary[@"rating"];
    self.photos = dictionary[@"photos"];
    self.types = dictionary[@"types"];
    [self setPlaceSpecificType];
    self.unformattedTimes = dictionary[@"opening_hours"];
    self.locked = NO;
    self.isHome = NO;
    self.scheduledTimeBlock = -1;
    self.timeToSpend = -1;
    self.arrivalTime = -1;
    self.departureTime = -1;
    self.travelTimeToPlace = @(-1);
    self.travelTimeFromPlace = @(-1);
    self.hasAlreadyGone = NO;
    self.isSelected = NO;
    [self makeScheduleDictionaries];
    return self;
}

- (instancetype)initWithName:(NSString *)name withCompletion:(void (^)(bool sucess, NSError *error))completion {
    __block Place *place;
    [[APIManager shared]getCompleteInfoOfLocationWithName:name withCompletion:^(NSDictionary *placeInfoDictionary, NSError *error) {
        if(placeInfoDictionary) {
            place = [place initWithDictionary:placeInfoDictionary];
            completion(YES, nil);
        }
        else {
            NSLog(@"could not get dictionary");
            completion(NO, error);
        }
    }];
    return place;
}

- (void)setArrivalDeparture:(TimeBlock)timeBlock {
    float travelTime = ([self.travelTimeToPlace floatValue] / 3600) + 10.0/60.0;
    switch(timeBlock) {
        case TimeBlockBreakfast:
            self.arrivalTime = 9 + travelTime;
            self.departureTime = getMax(self.arrivalTime + 0.5, 10);
            return;
        case TimeBlockMorning:
            self.arrivalTime = self.prevPlace.departureTime + travelTime;
            return;
        case TimeBlockLunch:
            self.prevPlace.departureTime = 12.5 - travelTime;
            self.arrivalTime = 12.5;
            self.departureTime = 13.5;
            return;
        case TimeBlockAfternoon:
            self.arrivalTime = self.prevPlace.departureTime + travelTime;
            self.departureTime = getMax(self.arrivalTime + 2, 17.5);
            return;
        case TimeBlockDinner:
            self.arrivalTime = self.prevPlace.departureTime + travelTime;
            self.departureTime = self.arrivalTime + 1.5;
            return;
        case TimeBlockEvening:
            self.arrivalTime = self.prevPlace.departureTime + travelTime;
            self.departureTime = 20 - ([self.travelTimeFromPlace floatValue] / 3600);
            return;
    }
}

#pragma mark - General Helper methods for initialization

- (void)createAllProperties {
    self.coordinates = [[NSDictionary alloc] init];
    self.types = [[NSArray alloc] init];
    self.unformattedTimes = [[NSDictionary alloc] init];
    self.openingTimesDictionary = [[NSMutableDictionary alloc] init];
    self.prioritiesDictionary = [[NSMutableDictionary alloc] init];
    self.imageView = [[UIImageView alloc] init];
}

#pragma mark - Methods to set type
-(void)setPlaceSpecificType {
    if([self.types containsObject:@"restaurant"]) {
        self.specificType = @"restaurant";
    }
    else if([self.types containsObject:@"lodging"]) {
        self.specificType = @"hotel";
    }
    else {
        self.specificType = @"attraction";
    }
}


#pragma mark - methods to make the dictionary of opening times and priorities
- (void)makeScheduleDictionaries{
    for(int dayIndexInt = 0; dayIndexInt <= 6; ++dayIndexInt){
        NSNumber *dayIndexNSNumber = [[NSNumber alloc] initWithInt:dayIndexInt];
        [self formatTimeForDay:dayIndexNSNumber];
        [self formatPriorityForDay:dayIndexNSNumber];
    }
}

-(void)formatPriorityForDay:(NSNumber *)day {
    NSMutableArray *arrayOfPeriodsForDay = self.openingTimesDictionary[day][@"periods"];
    int numberOfPeriodsForDayInt = (int)[arrayOfPeriodsForDay count];
    NSNumber *numberOfPeriodsForDayNSNumber = [NSNumber numberWithInt:numberOfPeriodsForDayInt];
    [self.prioritiesDictionary setObject:numberOfPeriodsForDayNSNumber forKey:day];
}

-(void)formatTimeForDay:(NSNumber *)day {
    int dayInt = [day intValue];
    NSDictionary *dayDictionary = self.unformattedTimes[@"periods"][dayInt];
    float openingTimeFloat;
    float closingTimeFloat;
    
    if([dayDictionary objectForKey:@"open"] == nil) {
        //Always closed
        openingTimeFloat = -1;
        closingTimeFloat = -1;
    }
    else if([dayDictionary objectForKey:@"close"] == nil) {
        //Always open
        openingTimeFloat = 0;
        closingTimeFloat = 0;
    }
    else {
        NSString *closingTimeString = dayDictionary[@"close"][@"time"];
        closingTimeFloat = [Date getFormattedTimeFromString:closingTimeString];
        NSString *openingTimeString = dayDictionary[@"open"][@"time"];
        openingTimeFloat = [Date getFormattedTimeFromString:openingTimeString];
    }
    
    NSNumber *openingTimeNSNumber = [[NSNumber alloc] initWithFloat:openingTimeFloat];
    NSNumber *closingTimeNSNumber = [[NSNumber alloc] initWithFloat:closingTimeFloat];
    
    NSMutableDictionary *newDictionaryForDay = [[NSMutableDictionary alloc] init];
    newDictionaryForDay[@"opening"] = openingTimeNSNumber;
    newDictionaryForDay[@"closing"] = closingTimeNSNumber;
    if([self.specificType isEqualToString:@"restaurant"]) {
        newDictionaryForDay[@"periods"] = [self getRestaurantsPeriodsArrayFromOpeningTime:openingTimeFloat toClosingTime:closingTimeFloat];
    }
    else {
        newDictionaryForDay[@"periods"] = [self getAttractionsPeriodsArrayFromOpeningTime:openingTimeFloat toClosingTime:closingTimeFloat];
    }
    self.openingTimesDictionary[day] = newDictionaryForDay;
    
}

-(NSMutableArray *)getAttractionsPeriodsArrayFromOpeningTime:(float)openingTime toClosingTime:(float)closingTime {
    NSMutableArray *arrayOfPeriods = [[NSMutableArray alloc] init];
    
    if (openingTime < 0) {
        //Closed all day
        return arrayOfPeriods;
    }
    
    if (fabsf(openingTime - 0) < 0.1 && fabsf(closingTime - 0) < 0.1){
        //Open all day
        [arrayOfPeriods addObject:@(TimeBlockBreakfast)];
        [arrayOfPeriods addObject:@(TimeBlockLunch)];
        [arrayOfPeriods addObject:@(TimeBlockDinner)];
        return arrayOfPeriods;
    }
    
    if (openingTime < 11 && closingTime >= 11) {
        [arrayOfPeriods addObject:@(TimeBlockBreakfast)];
    }
    if (closingTime >= 13) {
        [arrayOfPeriods addObject:@(TimeBlockLunch)];
    }
    if(closingTime >= 17) {
        [arrayOfPeriods addObject:@(TimeBlockDinner)];
    }
    
    return arrayOfPeriods;
}

-(NSMutableArray *)getRestaurantsPeriodsArrayFromOpeningTime:(float)openingTime toClosingTime:(float)closingTime {
    NSMutableArray *arrayOfPeriods = [[NSMutableArray alloc] init];
    
    if (openingTime < 0) {
        //Closed all day
        return arrayOfPeriods;
    }
    
    if (openingTime == 0 && closingTime == 0){
        //Open all day
        [arrayOfPeriods addObject:@(TimeBlockMorning)];
        [arrayOfPeriods addObject:@(TimeBlockAfternoon)];
        [arrayOfPeriods addObject:@(TimeBlockEvening)];
        return arrayOfPeriods;
    }
    
    if (openingTime < 11 && closingTime >= 11) {
        [arrayOfPeriods addObject:@(TimeBlockMorning)];
    }
    if (closingTime >= 16) {
        [arrayOfPeriods addObject:@(TimeBlockAfternoon)];
    }
    if(closingTime >= 19) {
        [arrayOfPeriods addObject:@(TimeBlockEvening)];
    }
    
    return arrayOfPeriods;
}

#pragma mark - Image methods
- (void)setImageViewOfPlace:(Place *)myPlace withPriority:(bool)priority withDispatch:(dispatch_semaphore_t)setUpCompleted withCompletion:(void (^)(UIImage *image, NSError *error))completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        GMSPlaceField fields = (GMSPlaceFieldPhotos);
        
        if(priority) {
            dispatch_semaphore_signal(setUpCompleted);
        }
        
        [self->_placesClient fetchPlaceFromPlaceID:myPlace.placeId placeFields:fields sessionToken:nil callback:^(GMSPlace * _Nullable place, NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"An error occurred %@", [error localizedDescription]);
                completion(nil, error);
                return;
            }
            if (place != nil) {
                GMSPlacePhotoMetadata *photoMetadata = [place photos][0];
                [self->_placesClient loadPlacePhoto:photoMetadata callback:^(UIImage * _Nullable photo, NSError * _Nullable error) {
                    if (error != nil) {
                        NSLog(@"Error loading photo metadata: %@", [error localizedDescription]);
                        completion(nil, error);
                        return;
                    } else {
                        //myPlace.imageView.image = photo;
                        completion((UIImage *)photo, nil);
                    }
                }];
            }
        }];
    });
}

#pragma mark - Google API Helper methods
-(void)getPlacesClient {
    if(self->_gotPlacesClient != YES){
        self->_placesClient = [GMSPlacesClient sharedClient];
        self->_gotPlacesClient = YES;
    }
}

@end
