//
//  MKTopicViewController.m
//  BSBDJ
//
//  Created by mike on 16/1/19.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKTopicViewController.h"
#import "MKTopicCell.h"
#import "MKTopic.h"
#import "HttpManager.h"
#import "MKShowPictureViewController.h"
#import "ZFPlayerView.h"

@interface MKTopicViewController ()<ZFPlayerViewDelegate>

/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, strong) HttpManager *manager;

@end

@implementation MKTopicViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRefresh];
    [self setupTableView];
}

static NSString * const MKTopicCellId = @"topic";

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView data source delegete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKTopic *topic = self.topics[indexPath.row];
    MKTopicCell *cell = cell = [tableView dequeueReusableCellWithIdentifier:MKTopicCellId];
    cell.topic = topic;
    return cell;
   
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKTopic *topic = self.topics[indexPath.row];
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void)addRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh:)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh:)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MKTopicCell class]) bundle:nil] forCellReuseIdentifier:MKTopicCellId];
//     [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MKTopicPictureCell class]) bundle:nil] forCellReuseIdentifier:MKTopicPictureCellId];
    
}

- (void)headerRefresh:(MJRefreshHeader *)header {
    [self.tableView.mj_footer endRefreshing];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    [self.manager getRequestDataWithUrl:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(id responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [MKTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        // 清空页码
        self.page = 0;
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}

- (void)footerRefresh:(MJRefreshHeader *)header {
    // 结束下拉
    [self.tableView.mj_header endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    [self.manager getRequestDataWithUrl:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(id responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        NSArray *newTopics = [MKTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        // 设置页码
        self.page = page;

    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)setupTableView {
    CGFloat top = 64 + 35;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
}

- (NSMutableArray *)topics {
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (HttpManager *)manager {
    if (_manager == nil) {
        _manager = [[HttpManager alloc]init];
    }
    return _manager;
}
@end
