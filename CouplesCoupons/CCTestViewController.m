//
//  CCTestViewController.m
//  CouplesCoupons
//
//  Created by eProximiti 10 on 5/22/14.
//  Copyright (c) 2014 Aaron.RIetschlin. All rights reserved.
//

#import "CCTestViewController.h"
#import <Parse/Parse.h>
#import "CCCoupon.h"

@interface CCTestViewController ()

@end

@implementation CCTestViewController

@synthesize image = _image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    PFQuery *query = [CCCoupon query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (CCCoupon *coupon in objects) {
            NSLog(@"Coupon: %@", coupon);
            if(!coupon.image){
                NSLog(@"Coupon image is valid!");
                _image.file = coupon.image;
                [_image loadInBackground:^(UIImage *image, NSError *error) {
                    if(error){
                        NSLog(@"ERROR! %@", error);
                    }else{
                        NSLog(@"No error occurred.");
                    }
                    NSLog(@"Image: %@", image);
                }];
                break;
            }else{
                NSLog(@"Coupon image is null.");
            }
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
