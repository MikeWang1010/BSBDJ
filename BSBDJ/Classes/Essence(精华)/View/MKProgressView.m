//
//  MKProgressView.m
//  BSBDJ
//
//  Created by mike on 16/1/27.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKProgressView.h"

@implementation MKProgressView

- (void)awakeFromNib {
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
//    self.progressTintColor = [UIColor grayColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}
@end
