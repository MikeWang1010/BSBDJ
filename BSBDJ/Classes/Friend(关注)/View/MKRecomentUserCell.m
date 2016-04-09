//
//  MKRecomentUserCell.m
//  BSBDJ
//
//  Created by mike on 16/1/13.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKRecomentUserCell.h"
#import "MKRecommentUserModel.h"
#import "UIImageView+Extension.h"

@interface MKRecomentUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *fanCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *focusOnButton;

@end

@implementation MKRecomentUserCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
    [UIImageView roundImageView:self.headIconImageView radius:(self.headIconImageView.height /2) border:0 borderColor:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUserModel:(MKRecommentUserModel *)userModel {
    _userModel = userModel;
    self.userNameLabel.text = userModel.screen_name;
    [self.headIconImageView sd_setImageWithURL:[NSURL URLWithString:userModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    NSString *fansCount = nil;
    if (userModel.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注", userModel.fans_count];
    } else { // 大于等于10000
        fansCount = [NSString stringWithFormat:@"%.1f万人关注", userModel.fans_count / 10000.0];
    }
    self.fanCountLabel.text = fansCount;
}
@end
