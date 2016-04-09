//
//  MKTopicVoiceView.h
//  BSBDJ
//
//  Created by mike on 16/1/29.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKTopic;

@interface MKTopicVoiceView : UIView
@property (nonatomic, strong) MKTopic *topic;

+ (instancetype)topicVoiceView;
@end
