//
//  MKLoginAndRegisterController.m
//  BSBDJ
//
//  Created by mike on 16/1/11.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKLoginAndRegisterController.h"
#import "UIButton+Extension.h"

@interface MKLoginAndRegisterController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewMarginLeft;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *registersButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;


@end

@implementation MKLoginAndRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.registersButton roundCornersButtonWithRadius:5.0 borderWidth:0 borderColor:nil];
     [self.loginButton roundCornersButtonWithRadius:5.0 borderWidth:0 borderColor:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_type == MKLoginAndRegisterTypeRegister ) {
        self.loginViewMarginLeft.constant = -[UIScreen mainScreen].bounds.size.width;
        self.loginRegisterBtn.selected = YES;
    }
}


/**
 *  显示白色状态栏
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/**
 *  关闭窗口
 */
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  注册、登陆切换
 */
- (IBAction)loginAndRegister:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self.view endEditing:YES];
    if (self.loginViewMarginLeft.constant == 0) {//显示注册
        self.loginViewMarginLeft.constant = -[UIScreen mainScreen].bounds.size.width;
        button.selected = YES;
    }else {//显示登陆
        self.loginViewMarginLeft.constant = 0;
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        [self.view layoutIfNeeded];
    }];
    
}


/**
 *  登陆
 */
- (IBAction)login:(id)sender {
    MKLog(@"登陆");
}

/**
 *  忘记密码
 */
- (IBAction)forgetPwd:(id)sender {
    MKLog(@"忘记密码");
}

/**
 *  注册
 */
- (IBAction)register:(id)sender {
    MKLog(@"注册");
}


@end
