//
//  MusicViewController.m
//  BaseProject
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicCategoryCell.h"
#import "MusicCategoryViewModel.h"
#import "MusicListViewController.h"
#import "MultimediaPlayView.h"

@interface MusicViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) MusicCategoryViewModel *categoryVM;
@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Factory addMenuItemToVC:self];
    self.title = @"音乐";
    [self.tableView.header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (MusicCategoryViewModel *)categoryVM {
	if(_categoryVM == nil) {
		_categoryVM = [[MusicCategoryViewModel alloc] init];
	}
	return _categoryVM;
}

- (UITableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[UITableView alloc]initWithFrame:CGRectZero style:0];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 170/2;
        [_tableView registerClass:[MusicCategoryCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.categoryVM refreshDataCompletionHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                }else{
                    [self.tableView reloadData];
                    //   重置脚部 没有更多数据
                    [_tableView.footer resetNoMoreData];
                }
                [_tableView.header endRefreshing];
            }];
        }];
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.categoryVM getMoreDataCompletionHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                }else{
                    [self.tableView reloadData];
                    if([self.categoryVM isHasMore]){
                        [_tableView.footer endRefreshing];
                    }else{
                        [_tableView.footer endRefreshingWithNoMoreData];
                    }
                }
            }];
        }];
	}
	return _tableView;
}

#pragma mark - UITableView
kRemoveCellSeparator

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categoryVM.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.titleLb.text = [self.categoryVM titleForRow:indexPath.row];
    [cell.iconIV.imageView setImageWithURL:[self.categoryVM iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"xxxxx"]];
    cell.orderLb.text = @(indexPath.row + 1).stringValue;
    cell.descLb.text = [self.categoryVM descForRow:indexPath.row];
    cell.numberLb.text = [self.categoryVM numberForRow:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MusicListViewController *vc =[[MusicListViewController alloc] initWithAlbumId:[self.categoryVM albumIdForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
