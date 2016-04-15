//
//  MKTopicVideoView.m
//  BSBDJ
//
//  Created by mike on 16/1/29.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKTopicVideoView.h"
#import "MKTopic.h"

@interface MKTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@end

@implementation MKTopicVideoView

+ (instancetype)topicVideoView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}


- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)setTopic:(MKTopic *)topic {
    _topic = topic;
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    // 时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];

}
@end
