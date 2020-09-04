//
//  LLAlertAdView.h
//  GoogleUtilities
//
//  Created by ZHK on 2020/9/4.
//  
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLAlertAdView : GADUnifiedNativeAdView

/// 标识符
@property (nonatomic, strong) NSString *identifier;

@property (nonatomic, strong) UIWindow *onWindow;

@end

NS_ASSUME_NONNULL_END
