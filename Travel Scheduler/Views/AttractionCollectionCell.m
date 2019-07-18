//
//  AttractionCollectionCell.m
//  Travel Scheduler
//
//  Created by aliu18 on 7/16/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

#import "AttractionCollectionCell.h"
#import "APIManager.h"

@implementation AttractionCollectionCell

- (void)setImage {
    self.imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.contentView.bounds.size.width,self.contentView.bounds.size.height)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.image=[UIImage imageNamed:@"heart3"];
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapImage:)];
    [self.imageView addGestureRecognizer:profileTapGestureRecognizer];
    [self.imageView setUserInteractionEnabled:YES];
    [self.contentView addSubview:self.imageView];
}
/*
- (void)setImage:(Place *)place {
    self.imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.contentView.bounds.size.width,self.contentView.bounds.size.height)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.image = place.image;
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapImage:)];
    [self.imageView addGestureRecognizer:profileTapGestureRecognizer];
    [self.imageView setUserInteractionEnabled:YES];
    [self.contentView addSubview:self.imageView];
}
*/

#pragma mark - tap action segue to details

- (void)didTapImage:(UITapGestureRecognizer *)sender{
    [self.delegate attractionCell:self didTap:self.place];
}

@end
