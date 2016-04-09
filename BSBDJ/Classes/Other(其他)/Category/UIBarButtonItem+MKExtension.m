//
//  UIBarButtonItem+MKExtension.m
//  BSBDJ
//
//  Created by mike on 16/1/8.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "UIBarButtonItem+MKExtension.h"

@implementation UIBarButtonItem (MKExtension)

+ (instancetype)barButtonItemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc]initWithCustomView:button];
}
@end
