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


// Better practice would probably be to put these in a class extension category
// for this object and expose a method:
// - (void)setupCellWithModel:(CCCoupon*)coupon;
// and let that method do all the tweaks to these things.
// (I'm just assuming the coupon is the model here)

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet PFImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *labelGradient;
@property (weak, nonatomic) IBOutlet UIView *foreground;

@end
