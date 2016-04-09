//
//  MKRecommentCategoryCell.m
//  BSBDJ
//
//  Created by mike on 16/1/13.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKRecommentCategoryCell.h"
#import "MKRecommentCategoryModel.h"

@interface MKRecommentCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *selecteView;

@end

@implementation MKRecommentCategoryCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.selecteView.backgroundColor = [UIColor redColor];
    self.backgroundColor = MKRGBColor(244, 244, 244);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selecteView.hidden = !selected;
     self.textLabel.textColor = selected ? self.selecteView.backgroundColor : MKRGBColor(78, 78, 78);
    // Configure the view for the selected state
}

- (void)setCategoryModel:(MKRecommentCategoryModel *)categoryModel {
    _categoryModel = categoryModel;
    self.textLabel.text = categoryModel.name;
}

@end
