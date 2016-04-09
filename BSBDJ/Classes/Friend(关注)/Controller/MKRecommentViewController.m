//
//  MKRecommentViewController.m
//  BSBDJ
//
//  Created by mike on 16/1/13.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKRecommentViewController.h"
#import "HttpManager.h"
#import "MKRecommentCategoryCell.h"
#import "MKRecomentUserCell.h"
#import "MKRecommentUserModel.h"
#import "MKRecommentCategoryModel.h"

@interface MKRecommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTabelView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (nonatomic, strong) NSArray *categoryArray;
@property (nonatomic, strong) NSArray *recommentUserArray;
@property (nonatomic, strong) HttpManager *manager;
/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation MKRecommentViewController

static NSString * const MKRecommentCategoryId = @"recommentCaregoryId";
static NSString * const MKRecommnetUserId = @"recommentUserId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置标题
    self.title = @"推荐关注";
    // 设置背景色
    self.view.backgroundColor = MKRGBColor(233., 233., 233.);
    [self setupSubTableView];

    [self setupRefresh];
    
    [self loadRecommentCategoryData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark TabelViewDataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.leftTabelView == tableView) {
        return self.categoryArray.count;
    }
    return [self.categoryArray[self.leftTabelView.indexPathForSelectedRow.row] users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.leftTabelView == tableView) {
        MKRecommentCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:MKRecommentCategoryId];
        cell.categoryModel = self.categoryArray[indexPath.row];
        return  cell;
    }else {
        MKRecomentUserCell *cell = [tableView dequeueReusableCellWithIdentifier:MKRecommnetUserId];
        MKRecommentUserModel *userModel = [self.categoryArray[self.leftTabelView.indexPathForSelectedRow.row] users][indexPath.row];
        cell.userModel = userModel;
        return cell;
    }
}

#pragma mark TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.rightTableView.mj_header endRefreshing];
    [self.rightTableView.mj_footer endRefreshing];
    MKRecommentCategoryModel *categoryModel = self.categoryArray[indexPath.row];
    if (categoryModel.users.count > 0) {
        [self.rightTableView reloadData];
    }else {
        [self.rightTableView.mj_header beginRefreshing];
        [self.rightTableView reloadData];
    }
}

- (void)setupSubTableView {
    self.leftTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.leftTabelView registerNib:[UINib nibWithNibName:NSStringFromClass([MKRecommentCategoryCell class]) bundle:nil ] forCellReuseIdentifier:MKRecommentCategoryId];
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MKRecomentUserCell class]) bundle:nil] forCellReuseIdentifier:MKRecommnetUserId];
    self.leftTabelView.backgroundColor = MKRGBColor(233., 233., 233.);
    self.rightTableView.backgroundColor = MKRGBColor(233., 233., 233.);
    // 设置inset
    self.leftTabelView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.leftTabelView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightTableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);//self.leftTabelView.contentInset;
    self.rightTableView.rowHeight = 70;
    
}

- (void)setupRefresh {
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadUsers)];
//    self.rightTableView.mj_header.backgroundColor = MKRGBColor(233., 233., 233.);
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.rightTableView.mj_footer.hidden = YES;
}

- (void)loadRecommentCategoryData {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    [self.manager getRequestDataWithUrl:url parameters:params success:^(id responseObject) {
        [SVProgressHUD dismiss];
        self.categoryArray = [MKRecommentCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.leftTabelView reloadData];
        
        [self.leftTabelView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self.rightTableView.mj_header beginRefreshing];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
    
}
- (void)loadUsers {
    [self.rightTableView.mj_footer endRefreshing];
    MKRecommentCategoryModel *categoryModel = self.categoryArray[self.leftTabelView.indexPathForSelectedRow.row];
    // 设置当前页码为1
    categoryModel.currentPage = 1;
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(categoryModel.id);
    params[@"page"] = @(categoryModel.currentPage);
    self.params = params;
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    [self.manager getRequestDataWithUrl:url parameters:params success:^(id responseObject) {
        NSArray *userArray = [MKRecommentUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [categoryModel.users removeAllObjects];
        [categoryModel.users addObjectsFromArray:userArray];
        categoryModel.total = [responseObject[@"total"]integerValue];
        [self.rightTableView reloadData];
        [self.rightTableView.mj_header endRefreshing];
        [self checkFooterState];
    } failure:^(NSError *error) {
        [self.rightTableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

- (void)loadMoreUsers {
    MKRecommentCategoryModel *categoryModel = self.categoryArray[self.leftTabelView.indexPathForSelectedRow.row];
    
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(categoryModel.id);
    params[@"page"] = @(++categoryModel.currentPage);
    self.params = params;
     NSString *url = @"http://api.budejie.com/api/api_open.php";
    [self.manager getRequestDataWithUrl:url parameters:params success:^(id responseObject) {
        NSArray *userArray = [MKRecommentUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [categoryModel.users addObjectsFromArray:userArray];
        [self.rightTableView reloadData];
        [self checkFooterState];
        
    } failure:^(NSError *error) {
        [self.rightTableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
    
}

/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState
{
    MKRecommentCategoryModel *categoryModel = self.categoryArray[self.leftTabelView.indexPathForSelectedRow.row];
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.rightTableView.mj_footer.hidden = (categoryModel.users.count == 0);
    
    // 让底部控件结束刷新
    if (categoryModel.users.count == categoryModel.total) { // 全部数据已经加载完毕
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    } else { // 还没有加载完毕
        [self.rightTableView.mj_footer endRefreshing];
    }
}

- (HttpManager *)manager {
    if (_manager == nil) {
        _manager = [[HttpManager alloc]init];
    }
    return _manager;
}

- (NSMutableDictionary *)params {
    if (_params == nil) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}
@end
