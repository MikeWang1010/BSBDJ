//
//  MKTopicPictureView.m
//  BSBDJ
//
//  Created by mike on 16/1/26.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKTopicPictureView.h"
#import "MKTopic.h"
#import "MKProgressView.h"
#import "MKShowPictureViewController.h"

@interface MKTopicPictureView ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@property (weak, nonatomic) IBOutlet MKProgressView *progressView;


@end

@implementation MKTopicPictureView

+ (instancetype)topicPictureView {
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
    [self.imageView addGestureRecognizer:tapGesture];
}

- (void)showBigImage:(UITapGestureRecognizer *)tapGesture {
        MKShowPictureViewController *showPictureVc = [[MKShowPictureViewController alloc]init];
        showPictureVc.topic = self.topic;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVc animated:YES completion:nil];
}

- (void)setTopic:(MKTopic *)topic
{
    _topic = topic;
  
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        topic.pictureProgress = 1.0 * receivedSize / expectedSize ;
        MKLog(@"topic.pictureProgress: %f",topic.pictureProgress);
        [self.progressView setProgress:topic.pictureProgress animated:NO];
                                                
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden =  YES;
        
        if (topic.isBigPicture) {
            UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
            CGFloat imageW = topic.pictureF.size.width;
            CGFloat imageH = imageW * image.size.height / image.size.width;
            [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }];   
    NSString *extension = topic.large_image.pathExtension;
    
    self.gifView.hidden = ![[extension lowercaseString] isEqualToString:@"gif"];
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
    }else
    {
        self.seeBigButton.hidden = YES;
    }
}

@end
