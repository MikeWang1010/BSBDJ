//
//  MKMeSquareViewCell.m
//  BSBDJ
//
//  Created by mike on 16/2/2.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKMeSquareViewCell.h"
#import "MKMeSquaresView.h"

@interface MKMeSquareViewCell ()

@property (nonatomic, weak) MKMeSquaresView *view;
@end

@implementation MKMeSquareViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        MKMeSquaresView *view = [[MKMeSquaresView alloc]init];
        self.view = view;
        [self.contentView addSubview:view];
    }
    return self;
}

- (void)setMeFrame:(MKMeFrame *)meFrame {
    _meFrame = meFrame;
    self.view.meFrame = meFrame;
}
@end
