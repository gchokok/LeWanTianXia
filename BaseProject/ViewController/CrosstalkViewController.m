//
//  CrosstalkViewController.m
//  BaseProject
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CrosstalkViewController.h"
#import "CrosstalkViewModel.h"
#import "CrosstalkCell.h"
#import "MultimediaPlayView.h"
@interface CrosstalkViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) CrosstalkViewModel *talkVM;
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation CrosstalkViewController

-(id)init{
    if (self = [super init]) {
        self.title = @"相声";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Factory addMenuItemToVC:self];
    [self.tableView.header beginRefreshing];
    [self.view addSubview:[MultimediaPlayView sharedInstance]];
    [[MultimediaPlayView sharedInstance] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.talkVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CrosstalkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.coverIV.imageView setImageWithURL:[self.talkVM imageURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    cell.titleLb.text = [self.talkVM titleForRow:indexPath.row];
    cell.playtimesLb.text = [self.talkVM playtimesForRow:indexPath.row];
    cell.likesLb.text = [self.talkVM likesForRow:indexPath.row];
    cell.durationLb.text = [self.talkVM durationForRow:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[MultimediaPlayView sharedInstance] playWithURL:[self.talkVM audioURLForRow:indexPath.row]];
    [MultimediaPlayView sharedInstance].playBtn.hidden = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CrosstalkViewModel *)talkVM {
	if(_talkVM == nil) {
		_talkVM = [[CrosstalkViewModel alloc] init];
	}
	return _talkVM;
}

- (UITableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:0];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 88;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_tableView registerClass:[CrosstalkCell class] forCellReuseIdentifier:@"Cell"];
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.talkVM refreshDataCompletionHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                }else{
                    [self.tableView reloadData];
                    [self.tableView.footer resetNoMoreData];
                }
                [self.tableView.header endRefreshing];
            }];
        }];
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.talkVM getMoreDataCompletionHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                    [self.tableView.footer endRefreshing];
                }else{
                    [self.tableView reloadData];
                    if (self.talkVM.isHasMore) {
                        [self.tableView.footer endRefreshing];
                    }else{
                        [self.tableView.footer endRefreshingWithNoMoreData];
                    }
                }
            }];
        }];
	}
	return _tableView;
}

@end
