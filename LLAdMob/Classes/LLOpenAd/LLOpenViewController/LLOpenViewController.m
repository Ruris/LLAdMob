//
//  LLOpenViewController.m
//  GoogleUtilities
//
//  Created by ZHK on 2020/8/24.
//
//

#import "LLOpenViewController.h"
#import "InterstitialAd.h"
#import "LLOpenLogoView.h"

@interface LLOpenViewController () <GADFullScreenContentDelegate>

/// 插页
@property (nonatomic, strong) GADInterstitialAd *interstitial;

/// Loading 视图
//@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

/// Logo 视图
//@property (nonatomic, strong) LLOpenLogoView *logoView;

/// 是否加载完成
@property (nonatomic, assign) BOOL finishLoading;

/// 是否正在移除
//@property (nonatomic, assign) BOOL isRemoving;

@end

@implementation LLOpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_identifier == nil) {
        [self hiddenAndRemove];
    } else {
        [self loadInterstitialWithIdentifier:_identifier];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self checkNeedHidden];
        });
    }
}

#pragma mark -

/// 检测是否需要隐藏
- (void)checkNeedHidden {
    if (_finishLoading == NO) {
        [self hiddenAndRemove];
    }
}

#pragma mark - Ad

/// 加载插页
/// @param identifier 插页标识符
- (void)loadInterstitialWithIdentifier:(NSString *)identifier {
    GADRequest *request = [GADRequest request];
    [GADInterstitialAd loadWithAdUnitID:identifier request:request completionHandler:^(GADInterstitialAd * _Nullable interstitialAd, NSError * _Nullable error) {
        if (error) {
            [self hiddenAndRemove];
            return;
        }
        if (interstitialAd && self.isRemoving == NO) {
            self.interstitial = interstitialAd;
            self.interstitial.fullScreenContentDelegate = self;
            [interstitialAd presentFromRootViewController:self];
        }
    }];
//    self.interstitial = [[GADInterstitialAd alloc] initWithAdUnitID:identifier];
//    _interstitial.delegate = self;
//    [_interstitial loadRequest:[GADRequest request]];
}

#pragma mark - GADFullScreenContentDelegate

/// Tells the delegate that an impression has been recorded for the ad.
- (void)adDidRecordImpression:(nonnull id<GADFullScreenPresentingAd>)ad {
    
}

/// Tells the delegate that a click has been recorded for the ad.
- (void)adDidRecordClick:(nonnull id<GADFullScreenPresentingAd>)ad {
    
}

/// Tells the delegate that the ad failed to present full screen content.
- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {
    [self hiddenAndRemove];
}

/// Tells the delegate that the ad will present full screen content.
- (void)adWillPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    
}

/// Tells the delegate that the ad will dismiss full screen content.
- (void)adWillDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    [self hiddenAndRemove];
}

/// Tells the delegate that the ad dismissed full screen content.
- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    
}

#pragma mark Ad Request Lifecycle Notifications

/// Called when an interstitial ad request succeeded. Show it at the next transition point in your
/// application such as when transitioning between view controllers.
//- (void)interstitialDidReceiveAd:(nonnull GADInterstitial *)ad {
//    _finishLoading = YES;
//    /// 准备就绪 并且当前 未进行移除动画
//    if (ad.isReady && self.isRemoving == NO) {
//        [ad presentFromRootViewController:self];
//    }
//}

/// Called when an interstitial ad request completed without an interstitial to
/// show. This is common since interstitials are shown sparingly to users.
//- (void)interstitial:(nonnull GADInterstitial *)ad didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
//    [self hiddenAndRemove];
//}

#pragma mark Display-Time Lifecycle Notifications

/// Called just before presenting an interstitial. After this method finishes the interstitial will
/// animate onto the screen. Use this opportunity to stop animations and save the state of your
/// application in case the user leaves while the interstitial is on screen (e.g. to visit the App
/// Store from a link on the interstitial).
//- (void)interstitialWillPresentScreen:(nonnull GADInterstitial *)ad {
//    NSLog(@"%s", __func__);
//}
//
///// Called when |ad| fails to present.
//- (void)interstitialDidFailToPresentScreen:(nonnull GADInterstitial *)ad {
//    [self hiddenAndRemove];
//    NSLog(@"%s", __func__);
//}
//
///// Called before the interstitial is to be animated off the screen.
//- (void)interstitialWillDismissScreen:(nonnull GADInterstitial *)ad {
//    [self hiddenAndRemove];
//    NSLog(@"%s", __func__);
//}
//
///// Called just after dismissing an interstitial and it has animated off the screen.
//- (void)interstitialDidDismissScreen:(nonnull GADInterstitial *)ad {
//    NSLog(@"%s", __func__);
//}
//
///// Called just before the application will background or terminate because the user clicked on an
///// ad that will launch another application (such as the App Store). The normal
///// UIApplicationDelegate methods, like applicationDidEnterBackground:, will be called immediately
///// before this.
//- (void)interstitialWillLeaveApplication:(nonnull GADInterstitial *)ad {
//    NSLog(@"%s", __func__);
//}

@end
