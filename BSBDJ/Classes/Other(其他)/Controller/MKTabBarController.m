//
//  MKTabBarController.m
//  BSBDJ
//
//  Created by mike on 16/1/8.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKTabBarController.h"
#import "MKNavigationController.h"
#import "MKTabBar.h"
#import "MKFriendViewController.h"
#import "MKMeViewController.h"
#import "MKEssenceViewController.h"
#import "MKNewViewController.h"

@implementation MKTabBarController
/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize {
    // 通过appearance统一设置所有UITabBarItem的文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [self setupChildVc:[[MKEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    [self setupChildVc:[[MKNewViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    [self setupChildVc:[[MKFriendViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVc:[[MKMeViewController alloc]init] title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
    
    //替换系统tabbar
    [self setValue:[[MKTabBar alloc]init] forKey:@"tabBar"];
}

/**
 *  添加控制器
 *
 *  @param vc          控制器
 *  @param title       控制器标题
 *  @param image       默认图片
 *  @param selectImage 选中图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    vc.title = title;
//    vc.view.backgroundColor = [UIColor yellowColor];
    [vc.tabBarItem setImage:[UIImage imageNamed:image]];
    [vc.tabBarItem setSelectedImage:[UIImage imageNamed:selectImage]];
    MKNavigationController *navController = [[MKNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:navController];
}

@end
