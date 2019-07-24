//
//  PlaceView.h
//  Travel Scheduler
//
//  Created by aliu18 on 7/23/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PlaceViewDelegate;

@interface PlaceView : UIView

@property (strong, nonatomic) Place *place;
@property (strong, nonatomic) UILabel *placeName;
@property (strong, nonatomic) UIImageView *placeImage;
@property (strong, nonatomic) UILabel *timeRange;
@property (weak, nonatomic) id<PlaceViewDelegate> delegate;
@property (strong, nonatomic) UIButton *editButton;

- (instancetype)initWithFrame:(CGRect)frame andPlace:(Place *)place;

@end

@protocol PlaceViewDelegate

- (void)placeView:(PlaceView *)view didTap:(Place *)place;
- (void)tappedEditPlace:(Place *)place;

@end

NS_ASSUME_NONNULL_END
