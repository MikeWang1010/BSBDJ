//
//  MKCommentHeaderView.m
//  BSBDJ
//
//  Created by mike on 16/1/29.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKCommentHeaderView.h"
@interface MKCommentHeaderView()
/** 文字标签 */
@property (nonatomic, weak) UILabel *label;
@end

@implementation MKCommentHeaderView

+ (instancetype)commentHeaderViewWithTabelView:(UITableView *)tableView {
    static NSString *commentId = @"commentId";
    MKCommentHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:commentId];
    if (headerView == nil) {
        headerView = [[MKCommentHeaderView alloc]initWithReuseIdentifier:commentId];
    }
    return headerView;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = MKRGBColor(233, 233, 233);
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = MKRGBColor(67, 67, 67);
        label.width = 200;
        label.x = MKTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = title;
}

@end
