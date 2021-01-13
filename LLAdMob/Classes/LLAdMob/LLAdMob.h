//
//  LLAdMob.h
//  LLAdMob
//
//  Created by ZHK on 2020/8/25.
//  
//

#import <Foundation/Foundation.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_14_0
#import <AppTrackingTransparency/ATTrackingManager.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface LLAdMob : NSObject

+ (void)registAdMob;

+ (void)requestTrackingAuthorizationWithCompletionHandler:(void(^)(ATTrackingManagerAuthorizationStatus status))completion API_AVAILABLE(ios(14));

@end

NS_ASSUME_NONNULL_END
