//
//  LLOpenAd.h
//  GoogleUtilities
//
//  Created by ZHK on 2020/8/24.
//  
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLOpenAd : NSObject

/// 注册插页开屏广告
/// @param identifier 广告标识符
+ (void)registWithInterstitialIndetifier:(NSString *)identifier;

/// 注册原生开屏广告
/// @param identifier 广告标识符
+ (void)registWithOpenAdIndetifier:(NSString *)identifier complete:(UIViewController *(^)(NSError *error))complete;

@end

NS_ASSUME_NONNULL_END
