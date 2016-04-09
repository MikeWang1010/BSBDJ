//
//  MKFriendViewController.m
//  BSBDJ
//
//  Created by mike on 16/1/9.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKFriendViewController.h"
#import "MKLoginAndRegisterController.h"
#import "MKRecommentViewController.h"
#import "UIButton+Extension.h"

@interface MKFriendViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end
@implementation MKFriendViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(leftBarItemClick)];
    self.view.backgroundColor = MKRGBColor(239, 239, 239);
    [self.loginBtn roundCornersButtonWithRadius:5.0 borderWidth:1.0 borderColor: [UIColor redColor]];
    [self.registerBtn roundCornersButtonWithRadius:5.0 borderWidth:1.0 borderColor: [UIColor redColor]];
    
}
- (IBAction)login {
    MKLoginAndRegisterController *loginAndRegisterVc = [[MKLoginAndRegisterController alloc]init];
    [self presentViewController:loginAndRegisterVc animated:YES completion:nil];
    MKLog(@"登录");
}

- (IBAction)newRegister {
    MKLoginAndRegisterController *loginAndRegisterVc = [[MKLoginAndRegisterController alloc]init];
    loginAndRegisterVc.type = MKLoginAndRegisterTypeRegister;
    [self presentViewController:loginAndRegisterVc animated:YES completion:nil];
    MKLog(@"注册");
}

- (void)leftBarItemClick {
    MKRecommentViewController *recommentVc = [[MKRecommentViewController alloc]init];
    [self.navigationController pushViewController:recommentVc animated:YES];
    MKLog(@"朋友点击");
}
@end
