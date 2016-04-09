//
//  MKAdViewController.m
//  BSBDJ
//
//  Created by mike on 16/4/8.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKAdViewController.h"
#import "MKScreenTools.h"

@interface MKAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *adImageView;
@property (weak, nonatomic) IBOutlet UIButton *dismissBtn;
@property (weak, nonatomic) IBOutlet UIImageView *adBackImageVIew;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adimageViewBottomConstraint;

@end

@implementation MKAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  IphoneScreenType type = [MKScreenTools screenToolGetIphoneScreenType];
    switch (type) {
        case IphoneScreenType4Or4s:
            self.adBackImageVIew.image = [UIImage imageNamed:@"adBackImage"];
            break;
        case IphoneScreenType5Or5s:
            self.adBackImageVIew.image = [UIImage imageNamed:@"adBackImage4"];
            break;
        case IphoneScreenType6:
            self.adBackImageVIew.image = [UIImage imageNamed:@"adBackImage4.7"];
            self.adimageViewBottomConstraint.constant = 110;
            break;
        case IphoneScreenType6Plus:
            self.adBackImageVIew.image = [UIImage imageNamed:@"adBackImage5.5"];
            self.adimageViewBottomConstraint.constant = 120;
            break;
            
        default:
            break;
    }
    [self.dismissBtn setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:1]];
    NSURL *url = [NSURL URLWithString:@"http://ubmcmm.baidustatic.com/media/v1/0f000n1RzrHI2eWIm1-X4f.jpg"] ;
    [self.adImageView sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismisBtnClick:nil];
        });
    }];
}
- (IBAction)dismisBtnClick:(id)sender {
    [UIView animateWithDuration:1.8 animations:^{
//        self.view.y = MKScreenH;//直接往下消失
        //放大，边透明消失
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)dealloc {
    MKLog(@"MKAdViewController销毁了");
}


@end
