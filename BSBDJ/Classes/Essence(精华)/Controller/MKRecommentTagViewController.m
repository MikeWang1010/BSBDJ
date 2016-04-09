//
//  MKRecommentTagViewController.m
//  BSBDJ
//
//  Created by mike on 16/1/23.
//  Copyright © 2016年 mike. All rights reserved.
//

#import "MKRecommentTagViewController.h"
#import "MKRecommentTag.h"
#import "MKRecommentTagCell.h"
#import "MKEssenceDataManager.h"

@interface MKRecommentTagViewController ()
@property (nonatomic, strong) NSArray *recommentArray;
@end

@implementation MKRecommentTagViewController
 static NSString *ID = @"MKRecommentTagCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabelView];
    [self loadData];
}

#pragma mark TableViewDataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.recommentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKRecommentTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.recommentTagModel = self.recommentArray[indexPath.row];
    return cell;
}


- (void)setupTabelView {
   
    self.navigationItem.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MKRecommentTagCell class]) bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = MKRGBColor(233, 233, 233);
}

- (void)loadData {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    MKEssenceDataManager *manager = [[MKEssenceDataManager alloc]init];
    [manager getRecommentTagDataSuccess:^(NSArray *data) {
        [SVProgressHUD dismiss];
        self.recommentArray = data;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
}



@end
