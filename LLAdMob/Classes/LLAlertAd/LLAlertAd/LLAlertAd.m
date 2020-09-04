//
//  LLAlertAd.m
//  GoogleUtilities
//
//  Created by ZHK on 2020/9/4.
//  
//

#import "LLAlertAd.h"
#import "LLAlertWindow.h"
#import "LLAlertAdView.h"

@implementation LLAlertAd

+ (void)registWithIndetifier:(NSString *)identifier {
    LLAlertAdView *view = [[LLAlertAdView alloc] init];
    LLAlertWindow *window = [[LLAlertWindow alloc] init];
    
    view.onWindow = window;
    view.identifier = identifier;
    [window addSubview:view];
    window.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.2f];
    
    [window makeKeyAndVisible];
}

@end
