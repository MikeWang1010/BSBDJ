//
//  MKMeSquaresView.m
//  BSBDJ
//
//  Created by mike on 16/2/2.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKMeSquaresView.h"
#import "MKSquareButton.h"
#import "HttpManager.h"
#import "MKSquare.h"
#import "MKMeFrame.h"

@interface MKMeSquaresView ()

@end

@implementation MKMeSquaresView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)setMeFrame:(MKMeFrame *)meFrame {
    if (_meFrame == meFrame) {
        return;
    }
    _meFrame = meFrame;
    NSArray *squareArray = meFrame.dataArray;
    // 创建方块
    [self createSquares:squareArray];
}


/**
 * 创建方块
 */
- (void)createSquares:(NSArray *)sqaures
{
    // 一行最多4列
    int maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = MKScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<sqaures.count; i++) {
        // 创建按钮
        MKSquareButton *button = [MKSquareButton buttonWithType:UIButtonTypeCustom];
        // 监听点击
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 传递模型
        button.square = sqaures[i];
        [self addSubview:button];
        
        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW +1;
        button.height = buttonH +1;
    }
    NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;
    // 计算高度
    self.meFrame.cellHeight = rows * buttonH;
    // 重绘
    [self setNeedsDisplay];
}

@end
