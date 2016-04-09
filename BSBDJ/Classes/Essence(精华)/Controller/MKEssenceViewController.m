//
//  MKEssenceViewController.m
//  BSBDJ
//
//  Created by mike on 16/1/19.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKEssenceViewController.h"
#import "MKTopicViewController.h"
#import "MKRecommentTagViewController.h"


@interface MKEssenceViewController ()<UIScrollViewDelegate>
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *topTagView;
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation MKEssenceViewController

- (void)viewDidLoad {
    //1.导航栏
    [self setupNav];
    //2.初始化子控制器
    [self setupSubViewController];
    //3.设置顶部标签栏
    [self setupTopTagView];
    //4.添加内容view
    [self setupcontentView];
}




- (void)setupNav {
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(leftItemClick)];
    self.view.backgroundColor = MKRGBColor(233, 233, 233);
}

- (void)leftItemClick {
    MKRecommentTagViewController *recommentVc = [[MKRecommentTagViewController alloc]init];
    [self.navigationController pushViewController:recommentVc animated:YES];
}

- (void)setupSubViewController {
    MKTopicViewController *allVc = [[MKTopicViewController alloc]init];
    allVc.type = MKTopicTypeAll;
    [self addChildViewController:allVc];
    MKTopicViewController *videoVc = [[MKTopicViewController alloc]init];
    videoVc.type = MKTopicTypeVideo;
    [self addChildViewController:videoVc];
    MKTopicViewController *voiceVc = [[MKTopicViewController alloc]init];
    voiceVc.type = MKTopicTypeVoice;
    [self addChildViewController:voiceVc];
    MKTopicViewController *pictureVc = [[MKTopicViewController alloc]init];
    pictureVc.type = MKTopicTypePicture;
    [self addChildViewController:pictureVc];
    MKTopicViewController *wordVc = [[MKTopicViewController alloc]init];
    wordVc.type = MKTopicTypeWord;
    [self addChildViewController:wordVc];
    
}

- (void)setupTopTagView {
    UIView *topTagView = [[UIView alloc]init];
    topTagView.height = 35.f;
    topTagView.x = 0;
    topTagView.y = 64;
    topTagView.width = self.view.width;
    topTagView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:topTagView];
    self.topTagView = topTagView;
    
    UIView * indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = topTagView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    NSArray *tagTitle = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat tagW = self.topTagView.width / tagTitle.count;
    CGFloat tagH = self.topTagView.height;
    for (NSInteger i = 0; i < tagTitle.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;
        [btn setTitle:tagTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.];
        btn.width = tagW;
        btn.height = tagH;
        btn.y = 0;
        btn.x = i * tagW;
        [btn addTarget:self action:@selector(tagTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topTagView addSubview:btn];
        if (i == 0) {
            btn.enabled = NO;
            self.selectedButton = btn;
            [btn.titleLabel sizeToFit];
            self.indicatorView.width = btn.titleLabel.width;
            self.indicatorView.centerX = btn.centerX;
        }
    }
    [topTagView addSubview:indicatorView];
}
- (void)tagTitleBtnClick:(UIButton *)btn {
    MKLog(@"tagTitleBtnClick");
    self.selectedButton.enabled = YES;
    btn.enabled = NO;
    self.selectedButton = btn;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = btn.titleLabel.width;
        self.indicatorView.centerX = btn.centerX;
    }];
    //滚动
    CGPoint offset  = self.contentView.contentOffset;
    offset.x = btn.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

- (void)setupcontentView {
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
//    contentView.backgroundColor = [UIColor redColor];
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.frame = self.view.frame;
    contentView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    [self.view insertSubview:contentView atIndex:0];
    
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UITableViewController *tableVc = self.childViewControllers[index];
    tableVc.view.x = scrollView.contentOffset.x;
    tableVc.view.y = 0;
    tableVc.view.height = scrollView.height;
    
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.topTagView.frame);
    tableVc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条的滚动边距
    tableVc.tableView.scrollIndicatorInsets = tableVc.tableView.contentInset;
    [scrollView addSubview:tableVc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width ;
    [self tagTitleBtnClick:self.topTagView.subviews[index]];
}
@end
