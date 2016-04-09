//
//  MKCommentHeaderView.h
//  BSBDJ
//
//  Created by mike on 16/1/29.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKCommentHeaderView : UITableViewHeaderFooterView
@property (nonatomic, copy) NSString *title;
+ (instancetype) commentHeaderViewWithTabelView:(UITableView *)tableView;
@end
