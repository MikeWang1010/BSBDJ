//
//  AppDelegate.m
//  BSBDJ
//
//  Created by mike on 16-1-7.
//  Copyright (c) 2016年 mike. All rights reserved.
//

#import "AppDelegate.h"
#import "MKTabBarController.h"
#import "MKPushNoticeView.h"
#import "MKAdViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    MKTabBarController *tabBarController = [[MKTabBarController alloc]init];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    MKAdViewController *adVc = [[MKAdViewController alloc]init];
    adVc.view.frame = [UIScreen mainScreen].bounds;
    [self.window addSubview:adVc.view];
    [[[MKPushNoticeView alloc]init] show];
    return YES;
}




- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if ([NSStringFromClass([[[window subviews]lastObject] class]) isEqualToString:@"UITransitionView"]) {
        return UIInterfaceOrientationMaskAll;
        //优酷 土豆  乐视  已经测试可以
    }
    return UIInterfaceOrientationMaskPortrait;
}
@end
