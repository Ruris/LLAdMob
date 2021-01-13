//
//  LLOpenAd.m
//  GoogleUtilities
//
//  Created by ZHK on 2020/8/24.
//  
//

#import "LLOpenAd.h"
#import "LLOpenWindow.h"
#import "LLOpenViewController.h"
#import "LLAppOpenAd.h"

@implementation LLOpenAd

/// 注册标识符
/// @param identifier 标识符
+ (void)registWithInterstitialIndetifier:(NSString *)identifier {
    /// 对象初始化
    LLOpenWindow *window = [[LLOpenWindow alloc] init];
    LLOpenViewController *controller = [[LLOpenViewController alloc] init];
    controller.identifier = identifier;
    
    /// 互相持有, 防止释放
    window.rootViewController = controller;
    controller.openWindow = window;
}

/// 注册原生开屏广告
/// @param identifier 广告标识符
+ (void)registWithOpenAdIndetifier:(NSString *)identifier complete:(UIViewController *(^)(NSError *error))complete {
    /// 对象初始化
    LLOpenWindow *window = [[LLOpenWindow alloc] init];
    LLoadingViewController *controller = [[LLoadingViewController alloc] init];
    
    /// 互相持有, 防止释放
    window.rootViewController = controller;
    controller.openWindow = window;
    
    /// 开始加载开屏广告
    [LLAppOpenAd openAdWithIdnentifier:identifier complete:^UIViewController * _Nullable(NSError * _Nullable error) {
        /// 隐藏 加载页面 和 window
        [controller hiddenAndRemove];
        return complete(error);
    }];
}

@end
