//
//  MKRecommentTagCell.h
//  BSBDJ
//
//  Created by mike on 16/1/23.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKRecommentTag;

@protocol MKRecommentTagCellDelegate <NSObject>

@optional
- (void) recommentTagCellDidButton:(UIButton *)button;
@end
@interface MKRecommentTagCell : UITableViewCell
@property (nonatomic, strong) MKRecommentTag *recommentTagModel;
@property (nonatomic, weak) id <MKRecommentTagCellDelegate> delegate;
@end
