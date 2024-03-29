//
//  LLAppDelegate.m
//  LLAdMob
//
//  Created by Ruris on 08/24/2020.
//  Copyright (c) 2020 Ruris. All rights reserved.
//

#import "LLAppDelegate.h"
#import <LLOpenAd.h>
#import <LLAdMob.h>
#import <LLAppOpenAd.h>
#import <GoogleMobileAds/GADMobileAds.h>

@implementation LLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ @"185ac8d37a43bf58e4d022fc9882759d" ];
    // Override point for customization after application launch.
    [LLAdMob registAdMob];
    if (@available(iOS 14, *)) {
        [LLAdMob requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            NSLog(@"ATTrackingManagerAuthorizationStatus: %ld", status);
        }];
    } else {
        // Fallback on earlier versions
    }
//    [LLOpenAd registWithInterstitialIndetifier:@"ca-app-pub-3940256099942544/4411468910"];
    
    
//    LLAppOpenAd app
    
//    LLAppOpenAd a
    
    [LLOpenAd registWithOpenAdIndetifier:@"ca-app-pub-3940256099942544/5662855259" complete:^UIViewController * _Nonnull(NSError * _Nonnull error) {
        return self.window.rootViewController;
    }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
