//
//  MKTopicCell.h
//  BSBDJ
//
//  Created by mike on 16/1/26.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKTopic;


@interface MKTopicCell : UITableViewCell
/** 帖子数据 */
@property (nonatomic, strong) MKTopic *topic;

+ (instancetype) topicCell;
@end
