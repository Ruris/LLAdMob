//
//  LLAppOpenAd.m
//  GoogleUtilities
//
//  Created by ZHK on 2020/8/24.
//  
//

#import "LLAppOpenAd.h"

@interface LLAppOpenAd () <GADInterstitialDelegate>

@property (nonatomic, copy) InterstitialLoadComplete complete;
@property (nonatomic, strong) GADAppOpenAd *appOpenAd;
@property (nonatomic, copy) NSString *identifier;

@end

@implementation LLAppOpenAd

+ (instancetype)openAdWithIdnentifier:(NSString *)identifier complete:(nonnull InterstitialLoadComplete)complete {
    LLAppOpenAd *ad = [[LLAppOpenAd alloc] init];
    ad.complete = complete;
    ad.identifier = identifier;
    [ad loadAppOpenAd];
    return ad;
}

- (void)loadAppOpenAd {
    [GADAppOpenAd loadWithAdUnitID:_identifier request:[GADRequest request] orientation:UIInterfaceOrientationPortrait completionHandler:^(GADAppOpenAd * _Nullable appOpenAd, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %s %@", __func__, error);
        }
        self.appOpenAd = appOpenAd;
        [appOpenAd presentFromRootViewController:self.complete(error)];
    }];
}

- (void)tryToPresentAd:(UIViewController *)viewController {
    if (_appOpenAd) {
        [_appOpenAd presentFromRootViewController:viewController];
    } else {
        [self loadAppOpenAd];
    }
}

#pragma mark Ad Request Lifecycle Notifications

/// Called when an interstitial ad request succeeded. Show it at the next transition point in your
/// application such as when transitioning between view controllers.
- (void)interstitialDidReceiveAd:(nonnull GADInterstitial *)ad {
    if (_complete) {
        [ad presentFromRootViewController:_complete(nil)];
    }
}

/// Called when an interstitial ad request completed without an interstitial to
/// show. This is common since interstitials are shown sparingly to users.
- (void)interstitial:(nonnull GADInterstitial *)ad didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
    if (_complete) {
        [ad presentFromRootViewController:_complete(error)];
    }
}

#pragma mark Display-Time Lifecycle Notifications

/// Called just before presenting an interstitial. After this method finishes the interstitial will
/// animate onto the screen. Use this opportunity to stop animations and save the state of your
/// application in case the user leaves while the interstitial is on screen (e.g. to visit the App
/// Store from a link on the interstitial).
- (void)interstitialWillPresentScreen:(nonnull GADInterstitial *)ad {
    
}

/// Called when |ad| fails to present.
- (void)interstitialDidFailToPresentScreen:(nonnull GADInterstitial *)ad {
    
}

/// Called before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(nonnull GADInterstitial *)ad {
    
}

/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidDismissScreen:(nonnull GADInterstitial *)ad {
    
}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store). The normal
/// UIApplicationDelegate methods, like applicationDidEnterBackground:, will be called immediately
/// before this.
- (void)interstitialWillLeaveApplication:(nonnull GADInterstitial *)ad {
    
}

@end
