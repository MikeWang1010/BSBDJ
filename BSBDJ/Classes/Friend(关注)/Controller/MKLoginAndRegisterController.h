//
//  MKLoginAndRegisterController.h
//  BSBDJ
//
//  Created by mike on 16/1/11.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, MKLoginAndRegisterType) {
    MKLoginAndRegisterTypeLogin,
    MKLoginAndRegisterTypeRegister
};

@interface MKLoginAndRegisterController : UIViewController
@property (nonatomic, assign) MKLoginAndRegisterType type;
@end
