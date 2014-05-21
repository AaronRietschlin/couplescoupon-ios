//
//  CCCoupon.h
//  CouplesCoupons
//
//  Created by eProximiti 10 on 5/20/14.
//  Copyright (c) 2014 Aaron.RIetschlin. All rights reserved.
//

#import <Parse/Parse.h>

@interface CCCoupon : PFObject<PFSubclassing>

+(NSString *)parseClassName;

@property (retain) NSString *title;
@property (retain) NSString *subtitle;
@property BOOL *isRedeemed;
@property (retain) NSString *ImageUrl;
@property (retain) PFFile *image;

@end
