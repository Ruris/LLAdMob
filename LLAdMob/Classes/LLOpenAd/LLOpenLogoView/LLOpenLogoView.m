//
//  LLOpenLogoView.m
//  GoogleUtilities
//
//  Created by ZHK on 2020/8/28.
//  
//

#import "LLOpenLogoView.h"

@interface LLOpenLogoView ()

/// logo 图片
@property (nonatomic, strong) UIImageView *imageView;
/// 名字
@property (nonatomic, strong) UILabel *nameLabel;

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
    [self addSubview:self.nameLabel];
    
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    
    CGFloat height = screenSize.width * 0.37;
    self.frame = CGRectMake(0.0,
                            screenSize.height - height,
                            screenSize.width,
                            height);
    
    CGFloat width = screenSize.width * 0.18;
    _imageView.frame = CGRectMake(0.0, 0.0, width, width);
    _imageView.center = CGPointMake(screenSize.width / 2, height / 2);
    
    _nameLabel.frame = CGRectMake(0.0, 0.0, screenSize.width, 20.0);
    _nameLabel.center = CGPointMake(_imageView.center.x, CGRectGetMaxY(_imageView.frame) + 20.0);
}

- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
    
    self.frame = CGRectMake(CGRectGetMinX(self.frame),
                            CGRectGetMinY(self.frame) - self.safeAreaInsets.bottom,
                            CGRectGetWidth(self.frame),
                            CGRectGetHeight(self.frame) + self.safeAreaInsets.bottom);
    _imageView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                    CGRectGetMidY(self.bounds) - self.safeAreaInsets.bottom / 2);
    _nameLabel.center = CGPointMake(_imageView.center.x,
                                    CGRectGetMaxY(_imageView.frame) + 20.0);
}

#pragma mark - Getter

- (UIImageView *)imageView {
    if (_imageView == nil) {
        self.imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"openLogo"];
    }
    return _imageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        self.nameLabel = [UILabel new];
        _nameLabel.text = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

@end
