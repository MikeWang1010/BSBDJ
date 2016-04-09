//
//  MKTagTextField.m
//  BSBDJ
//
//  Created by mike on 16/2/3.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKTagTextField.h"

@implementation MKTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行隔开";
        // 设置了占位文字内容以后, 才能设置占位文字的颜色
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = MKTagH;
    }
    return self;
}


- (void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();
    
    [super deleteBackward];
}

@end
