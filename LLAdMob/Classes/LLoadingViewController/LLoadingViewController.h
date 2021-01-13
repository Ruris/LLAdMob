//
//  LLoadingViewController.h
//  GoogleUtilities
//
//  Created by ZHK on 2020/8/24.
//  
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLoadingViewController : UIViewController

/// 首屏 window
@property (nonatomic, strong) UIWindow *openWindow;

/// 是否正在移除
@property (nonatomic, assign, readonly) BOOL isRemoving;

#pragma mark - Animation

/// 开始 loading 动画
- (void)startLoadingAnimation;

/// 结束 loading 动画
- (void)stopLoadingAnimation;

/// 隐藏并移除视图
- (void)hiddenAndRemove;

@end

NS_ASSUME_NONNULL_END
