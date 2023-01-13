//
//  LLViewController.m
//  LLAdMob
//
//  Created by Ruris on 08/24/2020.
//  Copyright (c) 2020 Ruris. All rights reserved.
//

#import "LLViewController.h"
#import <LLAlertAd.h>
#import <LLOpenAd.h>
#import <LLRewardAd.h>
#import <MBProgressHUD.h>

@interface LLViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray<NSString *> *titles;

@end

@implementation LLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI

- (void)setupUI {
    self.title = @"AdMob";
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *name = _titles[indexPath.row];
    if ([name isEqual:@"LLOpenAd-Native"]) {
//        [LLAppOpenAd openAdWithIdnentifier:@"ca-app-pub-3940256099942544/5662855259" complete:^UIViewController * _Nullable(NSError * _Nullable error) {
//            return self;
//        }];
        [LLOpenAd registWithOpenAdIndetifier:@"ca-app-pub-3940256099942544/5662855259" complete:^UIViewController * _Nonnull(NSError * _Nonnull error) {
            return self;
        }];
    }
    else if ([name isEqual:@"LLAlertAd"]) {
        [LLAlertAd registWithIndetifier:@"ca-app-pub-3940256099942544/3986624511"];
    }
    else if ([name isEqual:@"LLOpenAd-Interstitial"]) {
        [LLOpenAd registWithInterstitialIndetifier:@"ca-app-pub-3940256099942544/4411468910"];
    }
    else if ([name isEqual:@"LLRewardAd"]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [LLRewardAd showWithIdentifier:@"ca-app-pub-3940256099942544/1712485313" target:self loaded:^{
            NSLog(@"Loaded");
            [hud hideAnimated:YES];
        } reward:^{
            NSLog(@"Reward the user!");
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"Reward Error: %@", error);
        }];
    }
}

#pragma mark - Getter

- (NSArray *)titles {
    if (_titles == nil) {
        self.titles = @[
            @"LLAlertAd",
            @"LLOpenAd-Interstitial",
            @"LLOpenAd-Native",
            @"LLRewardAd"
        ];
    }
    return _titles;
}

@end
