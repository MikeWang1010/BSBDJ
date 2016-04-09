//
//  MKMeViewController.m
//  BSBDJ
//
//  Created by mike on 16/1/15.
//  Copyright © 2016年 mike. All rights reserved.
//



#import "MKMeViewController.h"
#import "UIBarButtonItem+MKExtension.h"
#import "MKMeTableViewCell.h"
#import "MKMeSquareViewCell.h"
#import "HttpManager.h"
#import "MKSquare.h"
#import "MKMeFrame.h"

@interface MKMeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) HttpManager *manager;
@end

@implementation MKMeViewController
- (void)viewDidLoad {
    [self loadData];
    [self setupNav];
    [self setupTable];
    
}
static NSString *MKMeId = @"me";
static NSString *MKSquareId = @"square";
- (void) setupNav {
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingItem = [UIBarButtonItem barButtonItemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:nil];
    UIBarButtonItem *moonItem = [UIBarButtonItem barButtonItemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
}

- (void) loadData {
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    [self.manager getRequestDataWithUrl:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(id responseObject) {
        NSArray *sqaures = [MKSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        NSMutableArray *dataArray = [NSMutableArray array];
        MKMeFrame *fistMeframe = [[MKMeFrame alloc]init];
        fistMeframe.dataArray = nil;
        fistMeframe.cellHeight = 44;
        [dataArray addObject:@[fistMeframe]];
        MKMeFrame *seconMeframe = [[MKMeFrame alloc]init];
        seconMeframe.dataArray = nil;
        seconMeframe.cellHeight = 44;
        [dataArray addObject:@[seconMeframe]];
        MKMeFrame *thirdMeframe = [[MKMeFrame alloc]init];
        thirdMeframe.dataArray = sqaures;
        [dataArray addObject:@[thirdMeframe]];
        _dataArray = dataArray;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}

- (void) setupTable {
    // 设置背景色
    self.tableView.backgroundColor = MKRGBColor(233, 233, 233);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MKMeTableViewCell class] forCellReuseIdentifier:MKMeId];
    [self.tableView registerClass:[MKMeSquareViewCell class] forCellReuseIdentifier:MKSquareId];
    
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = MKTopicCellMargin;
    
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(MKTopicCellMargin - 35, 0, 0, 0);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataArray[section];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
 if(indexPath.section == 2) {
       MKMeSquareViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MKSquareId];
         MKMeFrame *meFrame = self.dataArray[indexPath.section][indexPath.row];
        cell.meFrame = meFrame;
        return cell;
    }
   else if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MKMeId];
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MKMeId];
        cell.textLabel.text = @"离线下载";
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MKMeId];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKMeFrame *meFrame = self.dataArray[indexPath.section][indexPath.row];
    return meFrame.cellHeight;
}

- (HttpManager *)manager {
    if (_manager == nil) {
        _manager = [[HttpManager alloc]init];
    }
    return _manager;
}
@end
