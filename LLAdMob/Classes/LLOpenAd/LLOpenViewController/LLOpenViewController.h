//
//  LLOpenViewController.h
//  GoogleUtilities
//
//  Created by ZHK on 2020/8/24.
//  
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLOpenViewController : UIViewController

/// 标识符
@property (nonatomic, strong) NSString *identifier;

/// 首屏 window
@property (nonatomic, strong) UIWindow *openWindow;

@end

NS_ASSUME_NONNULL_END
