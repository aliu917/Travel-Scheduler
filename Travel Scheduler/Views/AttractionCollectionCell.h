//
//  AttractionCollectionCell.h
//  Travel Scheduler
//
//  Created by aliu18 on 7/16/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AttractionCollectionCellDelegate;
@protocol AttractionCollectionCellSetSelectedProtocol;

@interface AttractionCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) Place *place;
@property (nonatomic, weak) id<AttractionCollectionCellDelegate> delegate;
@property (nonatomic, weak) id<AttractionCollectionCellSetSelectedProtocol> setSelectedDelegate;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *checkmark;

- (instancetype)initWithPlace:(Place *)place;
- (void)setImage;

@end

@protocol AttractionCollectionCellDelegate

- (void)attractionCell:(AttractionCollectionCell *)attractionCell didTap:(Place *)place;

@end

@protocol AttractionCollectionCellSetSelectedProtocol
- (void)updateSelectedPlacesArrayWithPlace:(nonnull Place *)place;
@end

NS_ASSUME_NONNULL_END
