//
//  CCViewController.m
//  CouplesCoupons
//
//  Created by eProximiti 10 on 5/20/14.
//  Copyright (c) 2014 Aaron.RIetschlin. All rights reserved.
//

#import "CCViewController.h"
#import "CCCoupon.h"
#import "CCCouponTableViewCell.h"
#import <Parse/Parse.h>


@interface CCViewController ()

-(void)performLoadFromParse;
-(void)setColors;

@property NSMutableArray *coupons;

@property NSMutableArray *selectedCoupons;
@property CCCoupon *selectedCoupon;

@end

@implementation CCViewController

// Delete unnecessary methods - anything you didn't implement anything in that calls super is
// something to go byebye
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Maintain a consistent brace style dick! (Sucks there is no autoformat tool in ObjC land,
// well not by default - look into clang-format if you care)
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Load the data.
    [self performLoadFromParse];
    [self setColors];
    
}

-(void)setColors{
    // Set the bar tint color
    self.navigationController.navigationBar.barTintColor = [UIColor magentaColor];
    
    // Now set the background color of the view.
    NSString *hexColor =  @"#F8BBD0";
    NSUInteger red, green, blue;
    sscanf([hexColor UTF8String], "#%02X%02X%02X", &red, &green, &blue);
    self.view.backgroundColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) performLoadFromParse{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE; // Fuck you for using true. It is either YES or NO, never true
    PFQuery *query = [CCCoupon query];
    [query orderByAscending:@"redeemed"];
    [query whereKey:@"active" equalTo:@YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            self.coupons = [[NSMutableArray alloc] initWithArray:objects];
            [self.tableView reloadData];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    }];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *buttonText = [alertView buttonTitleAtIndex:buttonIndex];
    if([buttonText isEqualToString:@"Logout"]){
        // This is the logout
        [PFUser logOut];
        // NULL is actually good here since it is a block parameter! Conceptually it makes sense to use this instead of nil.
        // Just pointing this out because nil would work too but NULL really is better since
        // dereferencing a NULL (or nil) block will seg fault.
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    }else if(buttonIndex == 0){
        // Cancel was selected. Thus, we don't need to do anything.
    }else if(buttonIndex == 1){
        // OK was selected. Mark as redeemed and let the partner know.
        self.selectedCoupon.redeemed = YES; // you bastard mixing and matching YES and TRUE fuck
        [self.selectedCoupon saveInBackground];
        
        
        // Get the current user and its partner
        PFUser *current = [PFUser currentUser];
        if(current != nil){ // superfluous nil check, if (current) {...} is preferred
            PFUser* partner = [current objectForKey:@"partner"];
            NSLog(@"Partner: %@", partner);
            PFPush *push = [[PFPush alloc] init];
            [push setChannel:[NSString stringWithFormat:@"user_%@", partner.objectId]];
            NSString *name = [current objectForKey:@"name"];
            NSLog(@"Name: %@", name);
            [push setMessage:[NSString stringWithFormat:@"%@ redeemed: %@", name, self.selectedCoupon.title]];
            [push sendPushInBackground];
        }
        
        [self.tableView reloadData];
        
    }
    // Now remove it as the selected coupon
    self.selectedCoupon = nil;
    
}

-(IBAction)logout:(id)sender{
    // This is kinda shitty, UIAlertView doesn't keep a weak reference to its delegate - it
    // keeps unsafe_unretained, which means there is a (small) chance the Alert is up and the VC
    // goes away and then hitting a button in the alert crashes the app.

    // Personally I use BlocksKit to get around this (no delegate at all), but what you could do
    // is maintain a reference to this UIAlertView and in viewWillDisappear on the VC set the
    // alert view delegate to nil
    UIAlertView *logoutAlert = [[UIAlertView alloc] initWithTitle:@"Logout?" message:@"Are you sure you want to logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
    [logoutAlert show];
}

-(IBAction)refresh:(id)sender{
    [self performLoadFromParse];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.coupons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    CCCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CCCoupon *coupon = [self.coupons objectAtIndex:indexPath.row];
    // OK ya the coupon is the model - this code is much cleaner if the cell sets itself up
    // based on the model it receives
    cell.nameLabel.text = coupon.title;
    cell.detailLabel.text = coupon.subtitle;
    PFFile *image = coupon.image;
    if(image != nil){
        cell.imageView.file = image;
        [cell.imageView loadInBackground];
    }else if(!coupon.ImageUrl){
        //        [cell.imageView setIma]
    }
    
    // Set the opacity of the view
    if(coupon.redeemed){
        [cell.foreground setAlpha:1.0F];
    }
    
    return cell;
}

-(void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // makes it so that the cell does not remain selected.
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CCCoupon *coupon = [self.coupons objectAtIndex:indexPath.row];
    
    if(coupon.redeemed){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Coupon Redeemed" message:[NSString stringWithFormat:@"%@ is already redeemed. You can only redeem a coupon once.", coupon.title] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    }else{
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Redeem this coupon?" message:[NSString stringWithFormat:@"Would you like to redeem the following coupon: \n\n%@\n\nDoing so will remove this for future use.", coupon.title] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        
        // Add it to the list of selected
        if(self.selectedCoupons == nil){
            self.selectedCoupons = [[NSMutableArray alloc] init];
        }
        [self.selectedCoupons addObject:coupon];
        self.selectedCoupon = coupon;
        [view show];
    }
    
    NSLog(@"Current user: %@", [PFUser currentUser]);	
}

// BLEH FUCK ALL THIS AUTOGENERATED BULLSHIT
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
