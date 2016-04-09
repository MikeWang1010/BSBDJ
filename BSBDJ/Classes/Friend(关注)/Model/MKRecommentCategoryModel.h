//
//  MKRecommentCategoryModel.h
//  BSBDJ
//
//  Created by mike on 16/1/13.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKRecommentCategoryModel : NSObject
/** id */
@property (nonatomic, assign) NSInteger id;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
@end
