//
//  MusicListViewController.m
//  BaseProject
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MusicListViewController.h"
#import "MusicDetailCell.h"
#import "MusicDetailViewModel.h"
#import "MultimediaPlayView.h"
@interface MusicListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) MusicDetailViewModel *detailVM;
@end

@implementation MusicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Factory addBackItemToVC:self];
    [self.tableView.header beginRefreshing];
    [self.view addSubview:[MultimediaPlayView sharedInstance]];
    [[MultimediaPlayView sharedInstance] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];

}

kRemoveCellSeparator

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailVM.rowNumber;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.coverIV.imageView setImageWithURL:[self.detailVM coverURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"xxxxx"]];
    cell.titleLb.text=[self.detailVM titleForRow:indexPath.row];
    cell.timeLb.text = [self.detailVM timeForRow:indexPath.row];
    cell.sourceLb.text=[self.detailVM sourceForRow:indexPath.row];
    cell.playCountLb.text=[self.detailVM playCountForRow:indexPath.row];
    cell.favorCountLb.text=[self.detailVM favorCountForRow:indexPath.row];
    cell.commentCountLb.text=[self.detailVM commentCountForRow:indexPath.row];
    cell.durationLb.text = [self.detailVM durationForRow:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[MultimediaPlayView sharedInstance] playWithURL:[self.detailVM musicURLForRow:indexPath.row]];
    [MultimediaPlayView sharedInstance].playBtn.hidden = NO;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
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

- (MusicDetailViewModel *)detailVM {
	if(_detailVM == nil) {
		_detailVM = [[MusicDetailViewModel alloc] initWithAlbumId:_albumId];
	}
	return _detailVM;
}

- (UITableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:0];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_tableView registerClass:[MusicDetailCell class] forCellReuseIdentifier:@"Cell"];
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.detailVM refreshDataCompletionHandle:^(NSError *error) {
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
            [self.detailVM getMoreDataCompletionHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                    [self.tableView.footer endRefreshing];
                }else{
                    [self.tableView reloadData];
                    if (self.detailVM.isHasMore) {
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

-(id)initWithAlbumId:(NSInteger)albumId{
    if (self = [super init]) {
        _albumId = albumId;
    }
    return self;
}


@end
