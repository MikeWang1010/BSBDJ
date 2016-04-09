//
//  MKEssenceDataManager.h
//  BSBDJ
//
//  Created by mike on 16/1/23.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKEssenceDataManager : NSObject
- (void)getRecommentTagDataSuccess:(void(^)(NSArray *data)) success failure:(void(^)(NSError *error))failure;
@end
