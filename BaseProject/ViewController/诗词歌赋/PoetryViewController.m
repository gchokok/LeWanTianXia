//
//  PoetryViewController.m
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoetryViewController.h"
#import "KindViewModel.h"
#import "KindIntroViewController.h"

@interface PoetryCell : UITableViewCell
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) UILabel *label;
@end
@implementation PoetryCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.btn];
        [self.contentView addSubview:self.label];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(46, 30));
        }];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(_btn.mas_left).mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
        }];
        self.accessoryType = 1;
    }
    return self;
}

- (UIButton *)btn {
    if(_btn == nil) {
        _btn = [[UIButton alloc] init];
        [_btn setTitle:@"详情" forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:18];
        _btn.backgroundColor = [UIColor greenColor];
        _btn.tintColor = [UIColor whiteColor];
        _btn.layer.cornerRadius = 10;
    }
    return _btn;
}

- (UILabel *)label {
    if(_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:20];
        _label.numberOfLines = 0;
    }
    return _label;
}

@end

#import "PoetryListViewController.h"
#import "SearchPoetryViewModel.h"
#import "PoetryDetailViewController.h"

@interface PoetryViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong) KindViewModel *kindVM;
@property (nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) SearchPoetryViewModel *searchPoetryVM;
@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UISearchDisplayController *searchDisplayController;
@property(nonatomic,strong) NSArray *searchArr;
@end

@implementation PoetryViewController

+(UINavigationController *)standardInstance{
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        PoetryViewController *vc = [PoetryViewController new];
        navi = [[UINavigationController alloc]initWithRootViewController:vc];
    });
    return navi;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"诗词歌赋";
    [Factory addMenuItemToVC:self];
    self.tableView.tableHeaderView = self.searchBar;
    [self.searchDisplayController.searchResultsTableView registerClass:[PoetryListCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView reloadData];
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

- (KindViewModel *)kindVM {
	if(_kindVM == nil) {
		_kindVM = [[KindViewModel alloc] init];
	}
	return _kindVM;
}

#pragma mark - UITableView

kRemoveCellSeparator

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableView==tableView?self.kindVM.rowNumber:self.searchPoetryVM.rowNumber;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PoetryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (_tableView != tableView) {
        //如果是搜索界面
        cell.textLabel.text =[self.searchPoetryVM titleForRow:indexPath.row];
        cell.detailTextLabel.text = [self.searchPoetryVM authorForRow:indexPath.row];
        return cell;
    }
    cell.label.text = [self.kindVM titleForRow:indexPath.row];
    cell.btn.hidden = ![self.kindVM hasDetailForRow:indexPath.row];
    [cell.btn bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
    [cell.btn bk_addEventHandler:^(id sender) {
        KindIntroViewController *vc = [KindIntroViewController new];
        vc.introKind = [self.kindVM detailForRow:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        vc.title = cell.label.text;
    } forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView != _tableView) {
        PoetryDetailViewController *vc = [[PoetryDetailViewController alloc] initWithShi:[self.searchPoetryVM shiForRow:indexPath.row] intro:[self.searchPoetryVM shiIntroForRow:indexPath.row]];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    PoetryListViewController *vc = [[PoetryListViewController alloc]initWithKind:[self.kindVM titleForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView == _tableView;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除此诗集";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[UIAlertView bk_showAlertViewWithTitle:[self.kindVM titleForRow:indexPath.row] message:@"确认要删除此诗集吗？该操作无法恢复！" cancelButtonTitle:@"点错了" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                if ([self.kindVM removeKindForRow:indexPath.row]) {
                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }
        }] show];
    }
}

- (UITableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[PoetryCell class] forCellReuseIdentifier:@"Cell"];
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 52;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
	}
	return _tableView;
}

- (SearchPoetryViewModel *)searchPoetryVM {
	if(_searchPoetryVM == nil) {
		_searchPoetryVM = [[SearchPoetryViewModel alloc] initWithIndex:self.searchBar.selectedScopeButtonIndex];
	}
	return _searchPoetryVM;
}

#pragma mark - UISearchBar
//搜索栏内容有更改时触发
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchPoetryVM.searchStr = searchText;
    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    self.searchPoetryVM = [[SearchPoetryViewModel alloc]initWithIndex:selectedScope];
    self.searchPoetryVM.searchStr = self.searchBar.text;
    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (UISearchBar *)searchBar {
	if(_searchBar == nil) {
		_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kWindowW, 52)];
        _searchBar.placeholder = @"搜索";
        _searchBar.delegate = self;
        _searchBar.scopeButtonTitles = @[@"按诗名搜索",@"按作者搜索"];
	}
	return _searchBar;
}

- (UISearchDisplayController *)searchDisplayController {
	if(_searchDisplayController == nil) {
		_searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchDisplayController.searchResultsDelegate = self;
        _searchDisplayController.searchResultsDataSource = self;
	}
	return _searchDisplayController;
}

@end
