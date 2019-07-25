//
//  EditCell.m
//  Travel Scheduler
//
//  Created by aliu18 on 7/25/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

#import "EditCell.h"

@implementation EditCell

#pragma mark - EditCell lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (instancetype)initWithString:(NSString *)string
{
    self = [super init];
    self.string = string;
    [self createAllProperties];
    return self;
}

- (instancetype)initWithDate:(NSDate *)date
{
    self = [super init];
    self.date = date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE MM/dd/yyyy"];
    self.string = [dateFormat stringFromDate:date];
    [self createAllProperties];
    return self;
}

#pragma mark - Cell Selection methods

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)makeSelection:(int)width {
    double diameter = 12;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(width - 20 - (diameter / 2), (CGRectGetHeight(self.contentView.frame) / 2) - diameter / 2, diameter, diameter)];
    view.backgroundColor = [UIColor blueColor];
    view.layer.cornerRadius = view.frame.size.width / 2;
    view.clipsToBounds = YES;
    [self.contentView addSubview:view];
}

- (void)createAllProperties {
    self.contentView.frame = self.frame;
    self.indexPath = -1;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.contentView.frame) - 20, CGRectGetHeight(self.contentView.frame))];
    label.text = self.string;
    [self.contentView addSubview:label];
    self.tapView = [[UIView alloc] initWithFrame: self.frame];
    self.tapView.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.25];
    [self.contentView addSubview:self.tapView];
    UITapGestureRecognizer *cellTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchTime)];
    setupGRonImagewithTaps(cellTapRecognizer, self.tapView, 1);
}

- (void)switchTime {
    [self.delegate editCell:self didTap:self.place];
}

@end

