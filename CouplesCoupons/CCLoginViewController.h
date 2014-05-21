//
//  CCLoginViewController.h
//  CouplesCoupons
//
//  Created by eProximiti 10 on 5/19/14.
//  Copyright (c) 2014 Aaron.RIetschlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCLoginViewController : UIViewController

@property (nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic) IBOutlet UITextField *emailField;

-(IBAction)loginBtnClicked:(id)sender;

@end
