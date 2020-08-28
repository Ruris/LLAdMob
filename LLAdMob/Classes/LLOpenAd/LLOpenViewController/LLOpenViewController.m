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

@interface LLOpenViewController () <GADInterstitialDelegate>

/// 插页
@property (nonatomic, strong) GADInterstitial *interstitial;

/// Loading 视图
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

/// Logo 视图
@property (nonatomic, strong) LLOpenLogoView *logoView;

/// 是否加载完成
@property (nonatomic, assign) BOOL finishLoading;

/// 是否正在移除
@property (nonatomic, assign) BOOL isRemoving;

@end

@implementation LLOpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
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

#pragma mark - UI

- (void)setupUI {
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.loadingView];
    [self.view addSubview:self.logoView];
    
    [_loadingView startAnimating];
    _loadingView.center = self.view.center;
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    _loadingView.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                      CGRectGetMidY(self.view.bounds) - CGRectGetHeight(self.logoView.bounds) / 2);
}

#pragma mark -

/// 检测是否需要隐藏
- (void)checkNeedHidden {
    if (_finishLoading == NO) {
        [self hiddenAndRemove];
    }
}

/// 隐藏并移除视图
- (void)hiddenAndRemove {
    /// 标记为正在移除
    _isRemoving = YES;
    [UIView animateWithDuration:1.0 animations:^{
        self.openWindow.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.openWindow.rootViewController = nil;
    }];
}

#pragma mark - Ad

/// 加载插页
/// @param identifier 插页标识符
- (void)loadInterstitialWithIdentifier:(NSString *)identifier {
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:identifier];
    _interstitial.delegate = self;
    [_interstitial loadRequest:[GADRequest request]];
}

#pragma mark Ad Request Lifecycle Notifications

/// Called when an interstitial ad request succeeded. Show it at the next transition point in your
/// application such as when transitioning between view controllers.
- (void)interstitialDidReceiveAd:(nonnull GADInterstitial *)ad {
    _finishLoading = YES;
    /// 准备就绪 并且当前 未进行移除动画
    if (ad.isReady && _isRemoving == NO) {
        [ad presentFromRootViewController:self];
    }
}

/// Called when an interstitial ad request completed without an interstitial to
/// show. This is common since interstitials are shown sparingly to users.
- (void)interstitial:(nonnull GADInterstitial *)ad didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
    [self hiddenAndRemove];
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
    [self hiddenAndRemove];
}

/// Called before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(nonnull GADInterstitial *)ad {
    [self hiddenAndRemove];
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

#pragma mark - Getter

- (UIActivityIndicatorView *)loadingView {
    if (_loadingView == nil) {
        if (@available(iOS 13.0, *)) {
            self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        } else {
            self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        }
    }
    return _loadingView;
}

- (LLOpenLogoView *)logoView {
    if (_logoView == nil) {
        self.logoView = [[LLOpenLogoView alloc] init];
    }
    return _logoView;
}

@end
