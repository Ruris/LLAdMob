//
//  LLAppOpenAd.h
//  GoogleUtilities
//
//  Created by ZHK on 2020/8/24.
//  
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

typedef UIViewController *_Nullable(^InterstitialLoadComplete)(NSError * _Nullable error);

@interface LLAppOpenAd : NSObject

+ (instancetype)openAdWithIdnentifier:(NSString *)idnentifier complete:(InterstitialLoadComplete)complete;

- (void)tryToPresentAd:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
