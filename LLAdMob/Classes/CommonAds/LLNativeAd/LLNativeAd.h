//
//  LLNativeAd.h
//  NativeAdmobDemo
//
//  Created by ZHK on 2020/8/31.
//  Copyright © 2020 ZHK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GADNativeAd;
@protocol LLNativeAdDelegate <NSObject>

- (void)didReceiveNativeAd:(nullable GADNativeAd *)nativeAd error:(nullable NSError *)error;

@end

@interface LLNativeAd : NSObject

@property (nonatomic, weak) id<LLNativeAdDelegate> delegate;

+ (instancetype)nativeWithIdentifier:(nonnull NSString *)identifier;

- (void)loadAd;

@end

NS_ASSUME_NONNULL_END
