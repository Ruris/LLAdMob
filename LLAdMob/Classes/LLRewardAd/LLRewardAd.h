//
//  LLRewardAd.h
//  GoogleUtilities
//
//  Created by ZHK on 2023/1/13.
//  
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^LLRewardedCallback)(void);
typedef void(^LLRewardLoadedCallback)(void);
typedef void(^LLRewardFailureCallback)(NSError *);

/// 激励广告
@interface LLRewardAd : NSObject

/// 展示激励视频广告
/// @param identifier 广告标识符
/// @param target     ViewController
/// @param loaded     加载完成回调
/// @param reward     完成奖励回调
/// @param failure    失败回调
+ (void)showWithIdentifier:(NSString *)identifier
                    target:(UIViewController *)target
                    loaded:(LLRewardLoadedCallback)loaded
                    reward:(LLRewardedCallback)reward
                   failure:(LLRewardFailureCallback)failure;

@end

NS_ASSUME_NONNULL_END
