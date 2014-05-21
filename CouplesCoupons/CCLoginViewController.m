//
//  CCLoginViewController.m
//  CouplesCoupons
//
//  Created by eProximiti 10 on 5/19/14.
//  Copyright (c) 2014 Aaron.RIetschlin. All rights reserved.
//

#import "CCLoginViewController.h"
#import "CCLoginViewController.h"
#import <Parse/Parse.h>

@interface CCLoginViewController ()
-(void)moveToTableView;
@property BOOL isActivityShowing;
@end

@implementation CCLoginViewController

@synthesize emailField = _emailField;
@synthesize passwordField = _passwordField;
@synthesize progress = _progress;

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
    
    self.isActivityShowing = NO;
    
    // TODO - Check if current user is nil
    if(![PFUser currentUser]){
        [self moveToTableView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginBtnClicked:(id)sender{
    NSString *email = [_emailField text];
    NSString *password = [_passwordField text];
    NSLog(@"Email %@; Password: %@", email, password);
    
    if(!email || !password || [email length] == 0 || [password length] == 0){
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Invalid input" message:@"You must enter a valid email and password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    // If it got here, we can perform a login.
    [PFUser logInWithUsernameInBackground:email password:password block:^(PFUser *user, NSError *error){
        if(user){
            // SUCCESS!

            NSLog(@"Login was successful.");
            [self moveToTableView];
        }else{
            NSLog(@"Login was not success. Error %@", [error localizedDescription]);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    }];
    if(!_progress && !self.isActivityShowing){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    }
}

-(void)moveToTableView{
    // TODO - Add code to the other view controller with the Coupons.
    UIStoryboard *couponSB = [UIStoryboard storyboardWithName:@"coupons" bundle:nil];
    UITableViewController *vc = [couponSB instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController removeFromParentViewController];
                              
}

@end
