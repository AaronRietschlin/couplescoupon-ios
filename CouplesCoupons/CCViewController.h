//
//  CCViewController.h
//  CouplesCoupons
//
//  Created by eProximiti 10 on 5/20/14.
//  Copyright (c) 2014 Aaron.RIetschlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCViewController : UITableViewController <UIAlertViewDelegate>

// this shit should only be here if you want other classes with a reference to objects
// of this type to call these methods (pretty unlikely for all IBActions)

// if you wanna be explicit use a class extension category in the implementation
// and define them, it would look like this and go above your @implementation in the .m:

// @interface CCViewController()
//
// -(IBAction)logout:(id)sender;
// -(IBAction)refresh:(id)sender;
//
// @end
//
// Properties you do not want exposed to other classes should go in the class extension category
// as well.

-(IBAction)logout:(id)sender;
-(IBAction)refresh:(id)sender;

@end
