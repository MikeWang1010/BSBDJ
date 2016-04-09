//
//  MKScreenTools.h
//  BSBDJ
//
//  Created by mike on 16/4/8.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,IphoneScreenType ) {
    IphoneScreenType4Or4s=0,
    IphoneScreenType5Or5s=1,
    IphoneScreenType6=2,
    IphoneScreenType6Plus=3
};

@interface MKScreenTools : NSObject
+ (IphoneScreenType)screenToolGetIphoneScreenType;
@end
