//
//  MKTagButton.m
//  BSBDJ
//
//  Created by mike on 16/2/3.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKTagButton.h"

@implementation MKTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = MKTagBg;
        self.titleLabel.font = MKTagFont;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 3 * MKTagMargin;
    self.height = MKTagH;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = MKTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + MKTagMargin;
}

@end
