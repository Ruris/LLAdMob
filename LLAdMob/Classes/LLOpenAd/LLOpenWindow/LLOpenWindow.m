//
//  LLOpenWindow.m
//  GoogleUtilities
//
//  Created by ZHK on 2020/8/24.
//  
//

#import "LLOpenWindow.h"

@implementation LLOpenWindow

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
    self.windowLevel = 100;
    self.opaque = YES;
    [self makeKeyAndVisible];
}

@end
