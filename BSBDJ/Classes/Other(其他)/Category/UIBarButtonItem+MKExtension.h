//
//  UIBarButtonItem+MKExtension.h
//  BSBDJ
//
//  Created by mike on 16/1/8.
//  Copyright © 2016年 mike. All rights reserved.
//  导航栏 左右侧按钮分类

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MKExtension)

/**
 *  创建导航栏BarButtonItem
 *
 *  @param image     图片
 *  @param highImage 高亮
 *  @param target    目标对象
 *  @param action    方法
 *
 *  @return UIBarButtonItem
 */
+ (instancetype)barButtonItemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
