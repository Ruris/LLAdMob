//
//  LLAdMob.m
//  LLAdMob
//
//  Created by ZHK on 2020/8/25.
//  
//

#import "LLAdMob.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@implementation LLAdMob

+ (void)registAdMob {
    
#if TARGET_IPHONE_SIMULATOR
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ kGADSimulatorID ];
#endif
   
    /// iOS 14 AppTrackingTransparency 相关适配
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_14_0
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {

        }];
    } else {
        // Fallback on earlier versions
    }
#endif
    
    [[GADMobileAds sharedInstance] startWithCompletionHandler:^(GADInitializationStatus * _Nonnull status) {
            
    }];
}

+ (void)requestTrackingAuthorizationWithCompletionHandler:(void(^)(ATTrackingManagerAuthorizationStatus status))completion API_AVAILABLE(ios(14)) {
    [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:completion];
}

@end
