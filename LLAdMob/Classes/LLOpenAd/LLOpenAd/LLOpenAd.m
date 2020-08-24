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

@implementation LLOpenAd

/// 注册标识符
/// @param identifier 标识符
+ (void)registWithIndetifier:(NSString *)identifier {
    /// 对象初始化
    LLOpenWindow *window = [[LLOpenWindow alloc] init];
    LLOpenViewController *controller = [[LLOpenViewController alloc] init];
    controller.identifier = identifier;
    
    /// 互相持有, 防止释放
    window.rootViewController = controller;
    controller.openWindow = window;
}

@end
