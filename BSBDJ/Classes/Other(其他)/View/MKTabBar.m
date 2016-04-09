//
//  MKTabBar.m
//  BSBDJ
//
//  Created by mike on 16/1/8.
//  Copyright © 2016年 mike. All rights reserved.
//

#define kTabBarCount 5

#import "MKTabBar.h"
#import "MKPublishViewController.h"

@interface MKTabBar ()
@property (nonatomic, weak) UIButton *publishButton;//发布按钮
@end

@implementation MKTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置tabbar的背景图片
        UIImage *backGroundImage = [UIImage imageNamed:@"tabbar-light"];
        [self setBackgroundImage:backGroundImage];

        //添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publishButton.size = publishButton.currentImage.size;
        [publishButton addTarget:self action:@selector(publishTopic) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.width;
    CGFloat height = self.height;
    //设置发布按钮的frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    //设置其他按钮的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / kTabBarCount;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) {
            continue;
        }else {
            CGFloat buttonX = buttonW * ((index > 1)?(index + 1):(index));
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index ++;
        }
    }
    
}

- (void)publishTopic {
    MKPublishViewController *pushVc = [[MKPublishViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pushVc animated:YES completion:nil];
}
@end
