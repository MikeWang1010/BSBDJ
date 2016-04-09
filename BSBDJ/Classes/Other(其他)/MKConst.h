//
//  MKConst.h
//  BSBDJ
//
//  Created by mike on 16/1/26.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,MKTopicType) {
    
    MKTopicTypeAll = 1,
    MKTopicTypePicture = 10,
    MKTopicTypeWord = 29,
    MKTopicTypeVoice = 31,
    MKTopicTypeVideo = 41
};

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const MKTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const MKTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const MKTopicCellBottomBarH;
/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const MKTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const MKTopicCellPictureBreakH ;

/** XMGUser模型-性别属性值 */
UIKIT_EXTERN NSString * const MKUserSexMale;
UIKIT_EXTERN NSString * const MKUserSexFemale;

/** 标签-间距 */
UIKIT_EXTERN CGFloat const MKTagMargin;
/** 标签-高度 */
UIKIT_EXTERN CGFloat const MKTagH;