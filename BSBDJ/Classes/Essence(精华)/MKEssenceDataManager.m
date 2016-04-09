//
//  MKEssenceDataManager.m
//  BSBDJ
//
//  Created by mike on 16/1/23.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKEssenceDataManager.h"
#import "HttpManager.h"
#import "MKRecommentTag.h"

@implementation MKEssenceDataManager
- (void)getRecommentTagDataSuccess:(void(^)(NSArray *data)) success failure:(void(^)(NSError *error))failure {
    HttpManager *manager = [[HttpManager alloc]init];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [manager getRequestDataWithUrl:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(id responseObject) {
        NSArray *dataArray = [MKRecommentTag mj_objectArrayWithKeyValuesArray:responseObject];
        if (success) {
            success(dataArray);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
