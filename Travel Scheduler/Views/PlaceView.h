//
//  PlaceView.h
//  Travel Scheduler
//
//  Created by aliu18 on 7/23/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import "MoveCircleView.h"
#import "TravelView.h"
#import "ScheduleEventView.h"

@class MoveCircleView;
@class Place;
@class TravelView;

NS_ASSUME_NONNULL_BEGIN

@protocol PlaceViewDelegate;

@interface PlaceView : ScheduleEventView

@property (strong, nonatomic) Place *place;
@property (strong, nonatomic) UILabel *placeName;
@property (strong, nonatomic) UILabel *timeRange;
@property (weak, nonatomic) id<PlaceViewDelegate> delegate;
@property (strong, nonatomic) UIButton *editButton;
@property (strong, nonatomic) UIImageView *lockImage;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) MoveCircleView *bottomCircle;
@property (strong, nonatomic) MoveCircleView *topCircle;
@property (strong, nonatomic) CAGradientLayer *colorGradient;
@property (strong, nonatomic) UIButton *calendarButton;

- (instancetype)initWithFrame:(CGRect)frame andPlace:(Place *)place;
- (instancetype)initWithFrame:(CGRect)frame timeBlock:(TimeBlock)time;
- (void)unselect;
- (void)moveWithPan:(float)changeInY edge:(BOOL)top;

@end

@protocol PlaceViewDelegate

@property (strong, nonatomic) PlaceView *currSelectedView;
    
- (void)placeView:(PlaceView *)view didTap:(Place *)place;
- (void)removeLockFromPlace:(Place *)place;
- (void)tappedEditPlace:(Place *)place forView:(UIView *)view;
- (void)sendViewForward:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
