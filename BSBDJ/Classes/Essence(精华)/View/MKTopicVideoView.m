//
//  MKTopicVideoView.m
//  BSBDJ
//
//  Created by mike on 16/1/29.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKTopicVideoView.h"
#import "MKTopic.h"
#import "ZFPlayerView.h"

@interface MKTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (nonatomic, strong)  ZFPlayerView *playerView;
@end

@implementation MKTopicVideoView

+ (instancetype)topicVideoView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}


- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
//    self.imageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playVideo:)];
//    [self.imageView addGestureRecognizer:tapGes];
//    self.playerView = [[ZFPlayerView alloc]init];
//    
//    _playerView.hidden = YES;
////    [self insertSubview:_playerView atIndex:9999];
//    [self addSubview:_playerView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _playerView.frame = self.bounds;
}

- (void)playVideo:(UITapGestureRecognizer *)tapGes
{
    MKLog(@"playVideo");
//    _playerView.hidden = NO;
//    _playerView.videoURL = [NSURL URLWithString:self.topic.videouri];
}

- (void)setTopic:(MKTopic *)topic {
    _topic = topic;
    _playerView.hidden = YES;
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
