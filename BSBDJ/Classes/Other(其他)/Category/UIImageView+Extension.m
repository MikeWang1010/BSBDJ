//
//  UIImageView+Extension.m
//  BSBDJ
//
//  Created by mike on 16/1/14.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)
+ (void)roundImageView:(UIImageView *)imageView radius:(CGFloat)radius border:(CGFloat)border borderColor:(UIColor *)color; {
    imageView.layer.masksToBounds =YES;
    imageView.layer.cornerRadius =radius;
    imageView.layer.borderColor = color.CGColor;
    imageView.layer.borderWidth = border;
}
@end
