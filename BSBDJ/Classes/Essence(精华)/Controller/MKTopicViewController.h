//
//  MKTopicViewController.h
//  BSBDJ
//
//  Created by mike on 16/1/19.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKTopicViewController : UITableViewController
/** 帖子类型(交给子类去实现) */
@property (nonatomic, assign) MKTopicType type;
@end
