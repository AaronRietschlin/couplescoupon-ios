//
//  CCAppDelegate.m
//  CouplesCoupons
//
//  Created by eProximiti 10 on 5/19/14.
//  Copyright (c) 2014 Aaron.RIetschlin. All rights reserved.
//

#import "CCAppDelegate.h"
#import <Parse/Parse.h>
#import "CCCoupon.h"

@implementation CCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [CCCoupon registerSubclass];
    [Parse setApplicationId:@"et5ComWuTT0wfoLL3RkgACwBM6jc3GFTQHDVF4yh" clientKey:@"rok4zqbYmSiyZovrfhoVnlvbkclVm7FmtfxT02ua"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [PFImageView class];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
