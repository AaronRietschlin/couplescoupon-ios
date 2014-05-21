//
//  CCCoupon.m
//  CouplesCoupons
//
//  Created by eProximiti 10 on 5/20/14.
//  Copyright (c) 2014 Aaron.RIetschlin. All rights reserved.
//

#import "CCCoupon.h"
#import <Parse/PFObject+Subclass.h>

@implementation CCCoupon

@dynamic title;
@dynamic subtitle;
@dynamic isRedeemed;
@dynamic image;
@dynamic ImageUrl;

+(NSString *) parseClassName{
    return @"coupon";
}

@end
