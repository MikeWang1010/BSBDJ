//
//  MKTopicPictureView.h
//  BSBDJ
//
//  Created by mike on 16/1/26.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKTopic;

@protocol MKTopicPictureViewDelegate <NSObject>

@optional
- (void) topicPictureViewDid:(MKTopic *)topic;
@end

@interface MKTopicPictureView : UIView
/** 帖子数据 */
@property (nonatomic, strong) MKTopic *topic;
@property (nonatomic, weak) id <MKTopicPictureViewDelegate> delegate;

+ (instancetype)topicPictureView;
@end
