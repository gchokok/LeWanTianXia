//
//  LOLViewController.m
//  BaseProject
//
//  Created by apple on 16/7/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LOLViewController.h"
#import "TRImageView.h"
#import "ToolMenuViewModel.h"
#import "GameInfoHtmlViewController.h"
#import "BestGroupViewController.h"
#import "ZBCategoryViewController.h"
#import "SumAbilityViewController.h"

@interface  LOLCell: UITableViewCell
@property(nonatomic,strong) TRImageView *iconView;
@property(nonatomic,strong) UILabel *nameLb;
@end

@implementation LOLCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = 1;
    }
    return self;
}
- (UILabel *)nameLb {
    if(_nameLb == nil) {
        _nameLb = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self.iconView.mas_right).mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
    }
    return _nameLb;
}

- (TRImageView *)iconView {
    if(_iconView == nil) {
        _iconView = [[TRImageView alloc] init];
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(36, 36));
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _iconView;
}
@end

@interface LOLViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong) ToolMenuViewModel *toolVM;
@property(nonatomic,strong) UITableView *tableView;

@end
@implementation LOLViewController
+ (UINavigationController *)sharedInstance{
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LOLViewController *vc = [LOLViewController new];
        navi = [[UINavigationController alloc]initWithRootViewController:vc];
    });
    return navi;
}

- (ToolMenuViewModel *)toolVM {
    if(_toolVM == nil) {
        _toolVM = [[ToolMenuViewModel alloc] init];
    }
    return _toolVM;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LOLCell class] forCellReuseIdentifier:@"Cell"];
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 52;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.toolVM getDataFromNetCompleteHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                }else{
                    [_tableView reloadData];
                }
                [_tableView.header endRefreshing];
            }];
        }];
    }
    return _tableView;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.toolVM.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LOLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.iconView.imageView setImageWithURL:[self.toolVM iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"xxxxx"]];
    cell.nameLb.text = [self.toolVM titleForRow:indexPath.row];
    return cell;
}
kRemoveCellSeparator
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.toolVM itemTypeForRow:indexPath.row] == ToolMenuItemTypeWeb) {
        GameInfoHtmlViewController *vc=[[GameInfoHtmlViewController alloc] initWithURL:[self.toolVM webURLForRow:indexPath.row]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if ([[self.toolVM tagForRow:indexPath.row] isEqualToString:@"best_group"]) {
            BestGroupViewController *vc = [BestGroupViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([[self.toolVM tagForRow:indexPath.row] isEqualToString:@"item"]) {
            ZBCategoryViewController *vc = [ZBCategoryViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([[self.toolVM tagForRow:indexPath.row] isEqualToString:@"sum_ability"]) {
            SumAbilityViewController *vc = [SumAbilityViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"英雄联盟";
    [Factory addMenuItemToVC:self];
    [self.tableView.header beginRefreshing];
}

@end
