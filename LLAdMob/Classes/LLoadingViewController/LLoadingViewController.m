//
//  LLOpenViewController.m
//  GoogleUtilities
//
//  Created by ZHK on 2020/8/24.
//  
//

#import "LLoadingViewController.h"
#import "LLOpenLogoView.h"

@interface LLoadingViewController ()

/// Loading 视图
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

/// Logo 视图
@property (nonatomic, strong) LLOpenLogoView *logoView;

/// 是否正在移除
@property (nonatomic, assign) BOOL removing;

@end

@implementation LLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self startLoadingAnimation];
}

#pragma mark - UI

- (void)setupUI {
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.loadingView];
//    [self.view addSubview:self.logoView];
    _loadingView.center = self.view.center;
}

//- (void)viewSafeAreaInsetsDidChange {
//    [super viewSafeAreaInsetsDidChange];
//    _loadingView.center = CGPointMake(CGRectGetMidX(self.view.bounds),
//                                      CGRectGetMidY(self.view.bounds) - CGRectGetHeight(self.logoView.bounds) / 2);
//}

#pragma mark - Animation

/// 开始 loading 动画
- (void)startLoadingAnimation {
    [_loadingView startAnimating];
}

/// 结束 loading 动画
- (void)stopLoadingAnimation {
    [_loadingView stopAnimating];
}

/// 隐藏并移除视图
- (void)hiddenAndRemove {
    /// 标记为正在移除
    _removing = YES;
    _logoView.hidden = true;
    [UIView animateWithDuration:1.0 animations:^{
        self.openWindow.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.openWindow.rootViewController = nil;
    }];
}

#pragma mark - Getter

- (BOOL)isRemoving { return _removing; }

- (UIActivityIndicatorView *)loadingView {
    if (_loadingView == nil) {
        if (@available(iOS 13.0, *)) {
            self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        } else {
            self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        }
    }
    return _loadingView;
}

- (LLOpenLogoView *)logoView {
    if (_logoView == nil) {
        self.logoView = [[LLOpenLogoView alloc] init];
    }
    return _logoView;
}

@end
