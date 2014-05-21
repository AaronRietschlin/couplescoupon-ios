//
//  CCLoginViewController.m
//  CouplesCoupons
//
//  Created by eProximiti 10 on 5/19/14.
//  Copyright (c) 2014 Aaron.RIetschlin. All rights reserved.
//

#import "CCLoginViewController.h"
#import "CCLoginViewController.h"

@interface CCLoginViewController ()

@end

@implementation CCLoginViewController

@synthesize emailField = _emailField;
@synthesize passwordField = _passwordField;

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
    
    // TODO - Check if current user is nil
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
    
}

@end
