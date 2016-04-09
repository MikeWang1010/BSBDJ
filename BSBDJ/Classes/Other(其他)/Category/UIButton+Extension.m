//
//  UIButton+Extension.m
//  BSBDJ
//
//  Created by mike on 16/1/15.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
- (void)roundCornersButtonWithRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color {
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}
@end
