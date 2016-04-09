//
//  MKTopicVideoView.h
//  BSBDJ
//
//  Created by mike on 16/1/29.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKTopic;

@interface MKTopicVideoView : UIView
@property (nonatomic, strong) MKTopic *topic;

+ (instancetype)topicVideoView;
@end
