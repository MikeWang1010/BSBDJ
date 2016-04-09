//
//  MKNewViewController.m
//  BSBDJ
//
//  Created by mike on 16/2/16.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKNewViewController.h"
#import "UIBarButtonItem+MKExtension.h"

@interface MKNewViewController ()

@end

@implementation MKNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:nil];
    // 设置背景色
    self.view.backgroundColor = MKRGBColor(233, 233, 233);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
