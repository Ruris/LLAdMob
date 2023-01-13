//
//  LLRewardAd.m
//  GoogleUtilities
//
//  Created by ZHK on 2023/1/13.
//  
//

#import "LLRewardAd.h"
#import <GoogleMobileAds/GADMobileAds.h>



@interface LLRewardAd () <GADFullScreenContentDelegate>

/// 引用自己防止释放 (生命周期结束后置空释放对象)
@property (nonatomic, strong) id selfHolder;

/// 广告标识符
@property (nonatomic, strong) NSString *identifier;

/// 成功回调
@property (nonatomic, copy) LLRewardedCallback rewarded;

// 广告加载完成回调
@property (nonatomic, copy) LLRewardLoadedCallback loaded;

/// 失败回调
@property (nonatomic, copy) LLRewardFailureCallback failure;

/// 用于 present 出广告的视图控制器
@property (nonatomic, weak) UIViewController *targetViewController;

/// 激励广告对象
@property (nonatomic, strong) GADRewardedAd *ad;

@end

@implementation LLRewardAd

/// 展示激励视频广告
/// @param identifier 广告标识符
/// @param target     ViewController
/// @param reward     完成奖励回调
/// @param failure    失败回调
+ (void)showWithIdentifier:(NSString *)identifier
                    target:(UIViewController *)target
                    loaded:(LLRewardLoadedCallback)loaded
                    reward:(LLRewardedCallback)reward
                   failure:(LLRewardFailureCallback)failure {
    LLRewardAd *ad = [[LLRewardAd alloc] init];
    ad.identifier = identifier;
    ad.targetViewController = target;
    ad.loaded = loaded;
    ad.rewarded = reward;
    ad.failure = failure;
    [ad loadAd];
}

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        // 循环引用, 防止对象释放
        self.selfHolder = self;
    }
    return self;
}

#if DEBUG
- (void)dealloc {
    NSLog(@"LLRewardAd dealloc!");
}
#endif

#pragma mark - Private

/// 加载广告
- (void)loadAd {
    GADRequest *request = [GADRequest request];
    [GADRewardedAd loadWithAdUnitID:self.identifier
                            request:request
                  completionHandler:^(GADRewardedAd *ad, NSError *error) {
        // 处理错误信息
        if (error) {
            [self throwError:error];
            [self releaseSelf];
            return;
        }
        self.ad = ad;
        self.ad.fullScreenContentDelegate = self;
        [self callLoaded];
        // 展示广告并处理结果
        [ad presentFromRootViewController:self.targetViewController userDidEarnRewardHandler:^{
            [self rewardUser];
            [self releaseSelf];
        }];
    }];
}

/// 释放对象
- (void)releaseSelf {
    self.selfHolder = nil;
}

/// 调用加载完成回调
- (void)callLoaded {
    if (self.loaded) {
        self.loaded();
    }
}

/// 调用奖励用户回调
- (void)rewardUser {
    if (self.rewarded) {
        self.rewarded();
    }
}

/// 调用错误信息回调
/// @param error 错误信息对象
- (void)throwError:(NSError *)error {
    if (self.failure) {
        self.failure(error);
    }
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
    [self throwError:error];
    [self releaseSelf];
}

/// Tells the delegate that the ad will present full screen content.
- (void)adWillPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    
}

/// Tells the delegate that the ad will dismiss full screen content.
- (void)adWillDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    
}

/// Tells the delegate that the ad dismissed full screen content.
- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    
}

@end
