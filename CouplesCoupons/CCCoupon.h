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

// you wanna specify more stuff here, and use 'strong' not 'retain'
// strong over retain is purely cosmetic but is a sign that you're using ARC
// and not a doodoo head

// nonatomic is a big deal (atomic is the default) as it is much faster
@property (retain) NSString *title; // (nonatomic, strong)
@property (retain) NSString *subtitle;

// assign here because this is a non-object type - would be true of NSInteger (int/long 32bit/64bit) as well
@property BOOL redeemed; // (nonatomic, assign)
@property (retain) NSString *ImageUrl;
@property (retain) PFFile *image;

@end
