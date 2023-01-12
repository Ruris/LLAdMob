//
//  InterstitialAd.m
//  GoogleUtilities
//
//  Created by ZHK on 2020/8/24.
//  
//

#import "InterstitialAd.h"

@interface InterstitialAd () <GADFullScreenContentDelegate>

@property (nonatomic, copy) InterstitialLoadComplete complete;
@property (nonatomic, strong) GADInterstitialAd *interstitial;

@end

@implementation InterstitialAd

+ (instancetype)interstitialWithIdnentifier:(NSString *)idnentifier complete:(nonnull InterstitialLoadComplete)complete {
    InterstitialAd *ad = [[InterstitialAd alloc] init];
    ad.complete = complete;
    [ad loadInterstitialWithIdentifier:idnentifier];
    return ad;
}

- (void)loadInterstitialWithIdentifier:(NSString *)identifier {
    GADRequest *request = [GADRequest request];
    [GADInterstitialAd loadWithAdUnitID:identifier
                                  request:request
                        completionHandler:^(GADInterstitialAd *ad, NSError *error) {
        if (error) {
            NSLog(@"Failed to load interstitial ad with error: %@", [error localizedDescription]);
            return;
        }
        self.interstitial = ad;
        [ad presentFromRootViewController:self.complete(nil)];
    }];
//    self.interstitial = [[GADInterstitialAd alloc] initWithAdUnitID:identifier];
//    _interstitial.delegate = self;
//    [_interstitial loadRequest:[GADRequest request]];
}

#pragma mark Ad Request Lifecycle Notifications

///// Called when an interstitial ad request succeeded. Show it at the next transition point in your
///// application such as when transitioning between view controllers.
//- (void)interstitialDidReceiveAd:(nonnull GADInterstitial *)ad {
//    if (_complete) {
//        [ad presentFromRootViewController:_complete(nil)];
//    }
//}
//
///// Called when an interstitial ad request completed without an interstitial to
///// show. This is common since interstitials are shown sparingly to users.
//- (void)interstitial:(nonnull GADInterstitial *)ad didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
//    if (_complete) {
//        [ad presentFromRootViewController:_complete(error)];
//    }
//}

#pragma mark Display-Time Lifecycle Notifications

///// Called just before presenting an interstitial. After this method finishes the interstitial will
///// animate onto the screen. Use this opportunity to stop animations and save the state of your
///// application in case the user leaves while the interstitial is on screen (e.g. to visit the App
///// Store from a link on the interstitial).
//- (void)interstitialWillPresentScreen:(nonnull GADInterstitial *)ad {
//
//}
//
///// Called when |ad| fails to present.
//- (void)interstitialDidFailToPresentScreen:(nonnull GADInterstitial *)ad {
//
//}
//
///// Called before the interstitial is to be animated off the screen.
//- (void)interstitialWillDismissScreen:(nonnull GADInterstitial *)ad {
//
//}
//
///// Called just after dismissing an interstitial and it has animated off the screen.
//- (void)interstitialDidDismissScreen:(nonnull GADInterstitial *)ad {
//
//}
//
///// Called just before the application will background or terminate because the user clicked on an
///// ad that will launch another application (such as the App Store). The normal
///// UIApplicationDelegate methods, like applicationDidEnterBackground:, will be called immediately
///// before this.
//- (void)interstitialWillLeaveApplication:(nonnull GADInterstitial *)ad {
//
//}

@end
