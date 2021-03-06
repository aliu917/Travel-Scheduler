//
//  MoreOptionViewController.h
//  Travel Scheduler
//
//  Created by aliu18 on 7/16/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import "InfiniteScrollActivityView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MoreOptionViewControllerSetSelectedProtocol;

@interface MoreOptionViewController : UIViewController

@property (strong, nonatomic) NSString *stringType;
@property (strong, nonatomic) NSString *correctType;
@property (strong, nonatomic) NSMutableArray *places;
@property (strong, nonatomic) Place *hub;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonnull) UISearchBar *moreOptionSearchBarAutoComplete;
@property (strong, nonatomic) NSMutableArray *filteredPlaceToVisit;
@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) NSMutableArray *resultsArr;
@property (nonatomic) bool isMoreDataLoading;
@property (strong, nonatomic) UILabel *pressEnterLabel;
@property (weak, nonatomic) id<MoreOptionViewControllerSetSelectedProtocol> setSelectedDelegate;

@end

@protocol MoreOptionViewControllerSetSelectedProtocol
- (void)updateSelectedPlacesArrayWithPlace:(nonnull Place *)place;
@end

NS_ASSUME_NONNULL_END
