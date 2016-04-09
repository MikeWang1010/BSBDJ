//
//  MKTopic.m
//  BSBDJ
//
//  Created by mike on 16/1/26.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKTopic.h"
#import "NSDate+Extension.h"

@implementation MKTopic
{
    CGFloat _cellHeight;
    CGRect _pictureF;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };
}

- (NSString *)create_time {
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:_create_time];
    
    if (createDate.isThisYear) { // 今年
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:createDate];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createDate];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        return _create_time;
    }
}

-(CGFloat)cellHeight {
    //文字的最大尺寸
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * MKTopicCellMargin, MAXFLOAT);
    //文字的高度
    CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    // 文字部分的高度
    _cellHeight = MKTopicCellTextY + textH + MKTopicCellMargin;
    
    //图片类型
    if (self.type == MKTopicTypePicture) {
        
        CGFloat pictureW = maxSize.width;
        CGFloat pictureH = pictureW * self.height /self.width;
        if (pictureH >= MKTopicCellPictureMaxH) { // 图片高度过长
            pictureH = MKTopicCellPictureBreakH;
            self.bigPicture = YES; // 大图
        }
        CGFloat pictureX = MKTopicCellMargin;
        CGFloat pictureY = MKTopicCellTextY + textH + MKTopicCellMargin;
        _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        _cellHeight += pictureH + MKTopicCellMargin;
    }  else if (self.type == MKTopicTypeVoice) { // 声音帖子
        CGFloat voiceX = MKTopicCellMargin;
        CGFloat voiceY = MKTopicCellTextY + textH + MKTopicCellMargin;
        CGFloat voiceW = maxSize.width;
        CGFloat voiceH = voiceW * self.height / self.width;
        _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
        
        _cellHeight += voiceH + MKTopicCellMargin;
    }else if (self.type == MKTopicTypeVideo) {
        CGFloat videoX = MKTopicCellMargin;
        CGFloat videoY = MKTopicCellTextY + textH + MKTopicCellMargin;
        CGFloat videoW = maxSize.width;
        CGFloat videoH = videoW * self.height / self.width;
        _videoF = CGRectMake(videoX, videoY, videoW, videoH);
        
        _cellHeight += videoH + MKTopicCellMargin;
    }
    // 底部工具条的高度
    _cellHeight += MKTopicCellBottomBarH + MKTopicCellMargin;
    return _cellHeight;
}
@end
