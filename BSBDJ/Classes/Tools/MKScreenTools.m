//
//  MKScreenTools.m
//  BSBDJ
//
//  Created by mike on 16/4/8.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKScreenTools.h"

@implementation MKScreenTools
+ (IphoneScreenType)screenToolGetIphoneScreenType
{
    CGFloat screenSizeHeight=[UIScreen mainScreen].bounds.size.height;
    if (screenSizeHeight <= 480.0f) {
        return  IphoneScreenType4Or4s;
    }else if (screenSizeHeight <= 568.0f) {
        return  IphoneScreenType5Or5s;
    }
    else if (screenSizeHeight <= 667.0f) {
        return  IphoneScreenType6;
    }
    else {
      return  IphoneScreenType6Plus;
    }
}
@end
