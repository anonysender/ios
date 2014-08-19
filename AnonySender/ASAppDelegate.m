//
//  ASAppDelegate.m
//  AnonySender
//
//  Created by Jarred Sumner on 8/14/14.
//  Copyright (c) 2014 Uber. All rights reserved.
//

#import "ASAppDelegate.h"
#import "ASViewController.h"

@implementation ASAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ASViewController *viewController = [[ASViewController alloc] init];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:viewController];

    [self.window makeKeyAndVisible];

    return YES;
}

@end
