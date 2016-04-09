//
//  MKNavigationController.m
//  BSBDJ
//
//  Created by mike on 16/1/8.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKNavigationController.h"

@interface MKNavigationController ()

@property(nonatomic)NSUInteger orietation;

@end

@implementation MKNavigationController

+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    
}
-(BOOL)shouldAutorotate
{
    return NO;
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    //return UIInterfaceOrientationMaskLandscapeRight; 
    return self.orietation;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != self.orietation);
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {//不是第一个push进来的控制器，导航左边按钮单独设置
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setTitle:@"返回" forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        leftButton.size = CGSizeMake(70.f, 30.f);
        leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}
@end
