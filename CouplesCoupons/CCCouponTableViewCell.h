//
//  CCCouponTableViewCell.h
//  CouplesCoupons
//
//  Created by eProximiti 10 on 5/22/14.
//  Copyright (c) 2014 Aaron.RIetschlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CCCouponTableViewCell : PFTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet PFImageView *imageView;

@end
