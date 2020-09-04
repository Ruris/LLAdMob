//
//  LLAlertAdView.m
//  GoogleUtilities
//
//  Created by ZHK on 2020/9/4.
//  
//

#import "LLAlertAdView.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <Masonry.h>
#import "LLNativeAd.h"

#define SCALE_X (UIScreen.mainScreen.bounds.size.width / 414)

@interface LLAlertAdView () <LLNativeAdDelegate>

/// 图标
@property (strong, nonatomic) UIImageView *aiconView;

/// 描述内容
@property (strong, nonatomic) UILabel *bodyLabel;

/// 标题
@property (strong, nonatomic) UILabel *headLineLabel;

/// 开发商
@property (nonatomic, strong) UILabel *advertiserLabel;

/// 媒体视图
@property (strong, nonatomic) GADMediaView *amediaView;

/// 详情按钮
@property (nonatomic, strong) UIButton *detailButton;

/// 广告对象
@property (nonatomic, strong) LLNativeAd *nativeAdLoader;

@end

@implementation LLAlertAdView

#pragma mark - UI

- (void)setupUI {
    CGFloat scale = SCALE_X;
    
    self.backgroundColor = UIColor.whiteColor;
    self.layer.cornerRadius = 5.0f * scale;
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.0 * scale);
        make.right.mas_equalTo(-15.0 * scale);
        make.centerY.mas_equalTo(0.0);
    }];
    
    [self addSubview:self.aiconView];
    [self addSubview:self.headLineLabel];
    [self addSubview:self.advertiserLabel];
    [self addSubview:self.bodyLabel];
    [self addSubview:self.amediaView];
    [self addSubview:self.detailButton];
    
    [_aiconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.0 * scale);
        make.top.mas_equalTo(15.0 * scale);
        make.size.mas_equalTo(CGSizeMake(40.0 * scale, 40.0 * scale));
    }];
    
    [_headLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.aiconView.mas_right).offset(15.0 * scale);
        make.top.equalTo(self.aiconView);
        make.right.mas_equalTo(-15.0 * scale);
        make.height.mas_equalTo(20.0 * scale);
    }];
    
    [_advertiserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headLineLabel);
        make.bottom.equalTo(self.aiconView);
    }];
    
    [_bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.aiconView);
        make.right.equalTo(self.headLineLabel);
        make.top.equalTo(self.aiconView.mas_bottom).offset(10.0 * scale);
        make.height.mas_greaterThanOrEqualTo(1.0);
    }];
    
    [_amediaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bodyLabel);
        make.top.equalTo(self.bodyLabel.mas_bottom).offset(10.0 * scale);
        make.height.equalTo(self.amediaView.mas_width).multipliedBy(0.3);
    }];
    
    [_detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.amediaView);
        make.top.equalTo(self.amediaView.mas_bottom).offset(15.0 * scale);
        make.bottom.mas_equalTo(-15.0 * scale);
        make.size.mas_equalTo(CGSizeMake(90.0 * scale, 35.0 * scale));
    }];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview == nil) {
        return;
    }
    [self setupUI];
    [self.nativeAdLoader loadAd];
}

#pragma mark - LLNativeAdDelegate

- (void)didReceiveNativeAd:(GADUnifiedNativeAd *)nativeAd error:(NSError *)error {
    if (nativeAd == nil) {
        [self removeFromSuperview];
        return;
    }
    self.nativeAd = nativeAd;
    
    _aiconView.image = nativeAd.icon.image;
    _headLineLabel.text = nativeAd.headline;
    _advertiserLabel.text = nativeAd.advertiser;
    _bodyLabel.text = nativeAd.body;
    _amediaView.mediaContent = nativeAd.mediaContent;
    
    NSLog(@"nativeAd.advertiser: %@   %@   %f", nativeAd.advertiser, nativeAd.starRating, nativeAd.mediaContent.aspectRatio);
    
    /// 计算媒体部分宽高比
    CGFloat aspectRatio = 0.0;
    if (aspectRatio == 0.0 && nativeAd.images.count > 0) {
        CGSize size = nativeAd.images.firstObject.image.size;
        aspectRatio = size.height / size.width;
    }
    
    /// 限制宽高比, 避免超出屏幕
    if ([UIDevice.currentDevice.model.lowercaseString isEqualToString:@"ipad"]) {
        aspectRatio = MIN(aspectRatio, 1.1);
    } else {
        aspectRatio = MIN(aspectRatio, 1.5);
    }

    [_amediaView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bodyLabel);
        make.top.equalTo(self.bodyLabel.mas_bottom).offset(10.0 * SCALE_X);
        make.height.equalTo(self.mediaView.mas_width).multipliedBy(aspectRatio);
    }];
    
    [_detailButton setTitle:nativeAd.callToAction forState:UIControlStateNormal];
    _detailButton.hidden = nativeAd.callToAction.length == 0;
    
    [nativeAd registerClickConfirmingView:self.detailButton];
    [nativeAd registerAdView:self clickableAssetViews:@{
        GADUnifiedNativeCallToActionAsset : self.detailButton
    } nonclickableAssetViews:@{
        
    }];
}

#pragma mark - Getter

- (UIImageView *)aiconView {
    if (_aiconView == nil) {
        self.aiconView = [UIImageView new];
        _aiconView.layer.cornerRadius = 5.0 * SCALE_X;
        _aiconView.layer.borderColor = [UIColor.grayColor colorWithAlphaComponent:0.3].CGColor;
        _aiconView.layer.borderWidth = 0.5;
        _aiconView.clipsToBounds = YES;
    }
    return _aiconView;
}

- (UILabel *)headLineLabel {
    if (_headLineLabel == nil) {
        self.headLineLabel = [UILabel new];
        _headLineLabel.font = [UIFont boldSystemFontOfSize:15.0 * SCALE_X];
    }
    return _headLineLabel;
}

- (UILabel *)advertiserLabel {
    if (_advertiserLabel == nil) {
        self.advertiserLabel = [UILabel new];
    }
    return _advertiserLabel;
}

- (UILabel *)bodyLabel {
    if (_bodyLabel == nil) {
        self.bodyLabel = [UILabel new];
        _bodyLabel.font = [UIFont systemFontOfSize:13.0 * SCALE_X];
        _bodyLabel.numberOfLines = 3;
    }
    return _bodyLabel;
}

- (GADMediaView *)amediaView {
    if (_amediaView == nil) {
        self.amediaView = [[GADMediaView alloc] init];
    }
    return _amediaView;
}

- (UIButton *)detailButton {
    if (_detailButton == nil) {
        self.detailButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _detailButton.backgroundColor = UIColor.systemBlueColor;
        _detailButton.layer.cornerRadius = 17.5 * SCALE_X;
        _detailButton.titleLabel.font = [UIFont systemFontOfSize:15.0 * SCALE_X];
        [_detailButton setTitle:@"INSTALL" forState:UIControlStateNormal];
        [_detailButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    }
    return _detailButton;
}

- (LLNativeAd *)nativeAdLoader {
    if (_nativeAdLoader == nil) {
        self.nativeAdLoader = [LLNativeAd nativeWithIdentifier:_identifier];
        _nativeAdLoader.delegate = self;
    }
    return _nativeAdLoader;
}

#pragma mark -

- (UIView *)iconView { return self.aiconView; }

- (GADMediaView *)mediaView { return self.amediaView; }

- (UIView *)headlineView { return self.headLineLabel; }

- (UIView *)bodyView { return self.bodyLabel; }

- (UIView *)advertiserView { return self.advertiserLabel; }

- (UIView *)callToActionView { return self.detailButton; }

@end
