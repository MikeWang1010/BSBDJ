//
//  MKRecommentTagCell.m
//  BSBDJ
//
//  Created by mike on 16/1/23.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKRecommentTagCell.h"
#import "MKRecommentTag.h"
#import "UIImageView+Extension.h"


@interface MKRecommentTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UIButton *subscriptionBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end

@implementation MKRecommentTagCell

- (void)awakeFromNib {
    [self.subscriptionBtn addTarget:self action:@selector(subscriptionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)subscriptionBtnClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(recommentTagCellDidButton:)]) {
        [self.delegate recommentTagCellDidButton:button];
    }
}
- (void)layoutSubviews {
    [UIImageView roundImageView:self.titleImageView radius:self.titleImageView.width /2 border:0. borderColor:nil];
}
- (void)setRecommentTagModel:(MKRecommentTag *)recommentTagModel {
    _recommentTagModel = recommentTagModel;
    
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:recommentTagModel.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.titleLabel.text = recommentTagModel.theme_name;
    NSString *subNumber = nil;
    if (recommentTagModel.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", recommentTagModel.sub_number];
    } else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommentTagModel.sub_number / 10000.0];
    }
    self.countLabel.text = subNumber;
}
@end
