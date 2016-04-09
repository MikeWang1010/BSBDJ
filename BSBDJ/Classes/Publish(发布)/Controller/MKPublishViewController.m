//
//  MKPublishViewController.m
//  BSBDJ
//
//  Created by mike on 16/1/29.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKPublishViewController.h"
#import "MKVerticalButton.h"
#import <POP.h>
#import "MKPostWordViewController.h"
#import "MKNavigationController.h"
#import "MKTabBarController.h"

@interface MKPublishViewController ()

@end

@implementation MKPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (MKScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (MKScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        MKVerticalButton *button = [[MKVerticalButton alloc] init];
        button.tag = i;
        //[button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 计算X\Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - MKScreenH;
        button.frame = CGRectMake(buttonX, buttonBeginY, buttonW, buttonH);
        [button addTarget:self action:@selector(postMessage:) forControlEvents:UIControlEventTouchUpInside];
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = 10.;
        anim.springSpeed = 10.;
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;
        [button pop_addAnimation:anim forKey:@"position"];
    }
    
    // 添加标语
    
    
    
   
        UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
        [self.view addSubview:sloganView];
        // 标语动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerX = MKScreenW * 0.5;
        CGFloat centerEndY = MKScreenH * 0.2;
        CGFloat centerBeginY = centerEndY - MKScreenH;
        
        sloganView.center = CGPointMake(centerX, centerBeginY);
        
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
        anim.beginTime = CACurrentMediaTime() + images.count * 0.1;
        anim.springBounciness = 10.;
        anim.springSpeed = 10.;
        [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            // 标语动画执行完毕, 恢复点击事件
            self.view.userInteractionEnabled = YES;
        }];
        [sloganView pop_addAnimation:anim forKey:@"position"];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 * 先执行退出动画, 动画完毕后执行completionBlock
 */
- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    int beginIndex = 2;
    
    for (int i = beginIndex; i<self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + MKScreenH;
        // 动画的执行节奏(一开始很慢, 后面很快)
//                anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * 0.1;
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                // 执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

- (void)postMessage:(UIButton *)button {
    [self cancelWithCompletionBlock:^{
        NSInteger btnTag = button.tag;
        if (btnTag == 2) {
            MKPostWordViewController *postVc = [[MKPostWordViewController alloc]init];
            MKNavigationController *navVc = [[MKNavigationController alloc]initWithRootViewController:postVc];
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            [root presentViewController:navVc animated:YES completion:nil];
        }
    }];
}

- (IBAction)closeBtnClick:(id)sender {
    [self cancelWithCompletionBlock:nil];
}



@end
