//
//  MKRecommentCategoryModel.m
//  BSBDJ
//
//  Created by mike on 16/1/13.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKRecommentCategoryModel.h"

@implementation MKRecommentCategoryModel

- (NSMutableArray *)users {
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
