//
//  LLNativeAd.m
//  NativeAdmobDemo
//
//  Created by ZHK on 2020/8/31.
//  Copyright © 2020 ZHK. All rights reserved.
//

#import "LLNativeAd.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface LLNativeAd () <GADAdLoaderDelegate, GADVideoControllerDelegate, GADUnifiedNativeAdLoaderDelegate>

@property (nonatomic, strong) GADAdLoader *adLoader;

@property (nonatomic, copy) NSString *identifier;

@end

@implementation LLNativeAd

#pragma mark - Init

+ (instancetype)nativeWithIdentifier:(nonnull NSString *)identifier {
#if TARGET_IPHONE_SIMULATOR
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ kGADSimulatorID ];
#endif
#if DEBUG
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ @"5f3e932703d16c15218490ad2e0152f0" ];
#endif
    LLNativeAd *ad = [[self alloc] init];
    ad.identifier = identifier;
    return ad;
}

#pragma mark -

- (void)loadAd {
    if (_adLoader == nil) {
        GADNativeAdMediaAdLoaderOptions *mediaOptions = [[GADNativeAdMediaAdLoaderOptions alloc] init];
        GADVideoOptions *videoOptions = [[GADVideoOptions alloc] init];
        videoOptions.startMuted = NO;
        mediaOptions.mediaAspectRatio = GADMediaAspectRatioPortrait;
        self.adLoader = [[GADAdLoader alloc] initWithAdUnitID:_identifier
                                           rootViewController:nil
                                                      adTypes:@[kGADAdLoaderAdTypeUnifiedNative]
                                                      options:@[mediaOptions, videoOptions]];
        _adLoader.delegate = self;
    }
    [_adLoader loadRequest:[GADRequest request]];
}

#pragma mark - GADAdLoaderDelegate

/// Called when adLoader fails to load an ad.
- (void)adLoader:(nonnull GADAdLoader *)adLoader didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
    if ([_delegate respondsToSelector:@selector(didReceiveNativeAd:error:)]) {
        [_delegate didReceiveNativeAd:nil error:error];
    }
#if DEBUG
    if (error) {
        NSLog(@"Error: %@", error);
    }
#endif
}

/// Called after adLoader has finished loading.
- (void)adLoaderDidFinishLoading:(nonnull GADAdLoader *)adLoader {
#if DEBUG
    NSLog(@"%s", __func__);
#endif
}

#pragma mark - GADUnifiedNativeAdLoaderDelegate

- (void)adLoader:(GADAdLoader *)adLoader didReceiveNativeAd:(GADUnifiedNativeAd *)nativeAd {
    if ([_delegate respondsToSelector:@selector(didReceiveNativeAd:error:)]) {
        [_delegate didReceiveNativeAd:nativeAd error:nil];
    }
}

- (void)adLoader:(GADAdLoader *)adLoader didReceiveUnifiedNativeAd:(nonnull GADUnifiedNativeAd *)nativeAd {
    if ([_delegate respondsToSelector:@selector(didReceiveNativeAd:error:)]) {
        [_delegate didReceiveNativeAd:nativeAd error:nil];
    }
}

#pragma mark - GADVideoControllerDelegate

/// Tells the delegate that the video controller has began or resumed playing a video.
- (void)videoControllerDidPlayVideo:(nonnull GADVideoController *)videoController {
    
}

/// Tells the delegate that the video controller has paused video.
- (void)videoControllerDidPauseVideo:(nonnull GADVideoController *)videoController {
    
}

/// Tells the delegate that the video controller's video playback has ended.
- (void)videoControllerDidEndVideoPlayback:(nonnull GADVideoController *)videoController {
    
}

/// Tells the delegate that the video controller has muted video.
- (void)videoControllerDidMuteVideo:(nonnull GADVideoController *)videoController {
    
}

/// Tells the delegate that the video controller has unmuted video.
- (void)videoControllerDidUnmuteVideo:(nonnull GADVideoController *)videoController {
    
}

@end
