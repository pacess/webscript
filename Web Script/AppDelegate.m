//
//  AppDelegate.m
//  WhatsApp
//
//  Created by Pacess HO on 28/2/2019.
//  Copyright © 2019 Pacess Studio. All rights reserved.
//

//------------------------------------------------------------------------------
//  0    1         2         3         4         5         6         7         8
//  5678901234567890123456789012345678901234567890123456789012345678901234567890

#import "AppDelegate.h"

//==============================================================================
@implementation AppDelegate

//------------------------------------------------------------------------------
//  Override point for customization after application launch.
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions  {
	return YES;
}

//------------------------------------------------------------------------------
//  Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//  Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
- (void)applicationWillResignActive:(UIApplication *)application  {
}

//------------------------------------------------------------------------------
//  Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//  If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
- (void)applicationDidEnterBackground:(UIApplication *)application  {
}

//------------------------------------------------------------------------------
- (void)applicationWillEnterForeground:(UIApplication *)application  {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

//------------------------------------------------------------------------------
// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
- (void)applicationDidBecomeActive:(UIApplication *)application  {
}

//------------------------------------------------------------------------------
//  Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
- (void)applicationWillTerminate:(UIApplication *)application  {
}

@end
