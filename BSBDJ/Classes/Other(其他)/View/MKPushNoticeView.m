//
//  MKPushNoticeView.m
//  BSBDJ
//
//  Created by mike on 16/1/9.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKPushNoticeView.h"
@interface MKPushNoticeView ()

@property (nonatomic, weak) UIImageView *topImageView;
@property (nonatomic, weak) UIImageView *middleImageView;
@property (nonatomic, weak) UIImageView *bottomImageView;
@property (nonatomic, weak) UIButton *closeButton;
@end

@implementation MKPushNoticeView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubView];
    }
    return self;
}

- (void)layoutSubviews {
    [self.middleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@240);
        make.height.equalTo(@125);
    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.middleImageView.mas_top).offset(-40);
        make.width.equalTo(@250);
        make.height.equalTo(@55);
    }];
    
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.middleImageView.mas_bottom).offset(5);
        make.width.equalTo(@130);
        make.height.equalTo(@90);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomImageView.mas_left);
        make.bottom.equalTo(self.bottomImageView.mas_bottom);
        make.width.equalTo(@103);
        make.height.equalTo(@44);
    }];
}

- (void)setupSubView {
    UIImageView *topImageView = [[UIImageView alloc]init];
    topImageView.image = [UIImage imageNamed:@"pushguidetop"];
    [self addSubview:topImageView];
    self.topImageView = topImageView;
    
    UIImageView *middleImageView = [[UIImageView alloc]init];
    middleImageView.image = [UIImage imageNamed:@"pushguidemid"];
    [self addSubview:middleImageView];
    self.middleImageView = middleImageView;
    
    UIImageView *bottomImageView = [[UIImageView alloc]init];
    bottomImageView.image = [UIImage imageNamed:@"pushguidebot"];
    [self addSubview:bottomImageView];
    self.bottomImageView = bottomImageView;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    self.closeButton = button;
}
- (void)show {
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:oldVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.frame = window.bounds;
        [window addSubview:self];
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)closeView {
    [self removeFromSuperview];
}
@end
