//
//  MKTagTextField.h
//  BSBDJ
//
//  Created by mike on 16/2/3.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKTagTextField : UITextField
/** 按了删除键后的回调 */
@property (nonatomic, copy) void (^deleteBlock)();
@end
