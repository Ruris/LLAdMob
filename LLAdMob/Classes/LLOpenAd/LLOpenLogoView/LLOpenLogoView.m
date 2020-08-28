//
//  LLOpenLogoView.m
//  GoogleUtilities
//
//  Created by ZHK on 2020/8/28.
//  
//

#import "LLOpenLogoView.h"

static CGFloat kLogiViewHeight = 150.0;

@interface LLOpenLogoView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LLOpenLogoView

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI

- (void)setupUI {
    self.backgroundColor = UIColor.whiteColor;
    
    [self addSubview:self.imageView];
    
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    
    CGFloat height = screenSize.width * 0.37;
    self.frame = CGRectMake(0.0,
                            screenSize.height - height,
                            screenSize.width,
                            height);
    
    CGFloat width = screenSize.width * 0.18;
    _imageView.frame = CGRectMake(0.0, 0.0, width, width);
    _imageView.center = CGPointMake(screenSize.width / 2, height / 2);

}

- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
    
    self.frame = CGRectMake(CGRectGetMinX(self.frame),
                            CGRectGetMinY(self.frame) - self.safeAreaInsets.bottom,
                            CGRectGetWidth(self.frame),
                            CGRectGetHeight(self.frame) + self.safeAreaInsets.bottom);
    _imageView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                    CGRectGetMidY(self.bounds) - self.safeAreaInsets.bottom / 2);
}

#pragma mark - Getter

- (UIImageView *)imageView {
    if (_imageView == nil) {
        self.imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"openLogo"];
    }
    return _imageView;
}

@end
