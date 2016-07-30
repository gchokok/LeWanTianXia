//
//  GameInfoListViewController.m
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "GameInfoListViewController.h"
#import "GameInfoListCell.h"
#import "GameInfoViewModel.h"
#import "GameInfoImageCell.h"
#import "iCarousel.h"
#import "GameInfoHtmlViewController.h"
#import "GameInfoPicViewController.h"

@interface GameInfoListViewController ()<iCarouselDelegate,iCarouselDataSource>
@property(nonatomic,strong)GameInfoViewModel *gameVM;
@end

@implementation GameInfoListViewController
{//添加成员变量,因为不需要懒加载,所以不需要是属性
    iCarousel *_ic;
    UIPageControl *_pageControl;
    UILabel *_titleLb;
    NSTimer *_timer;
}
/** 头部滚动视图 */
-(UIView *)headerView{
    [_timer invalidate];//关定时器
    //如果当前没有头部视图,返回nil
    if(!self.gameVM.isExistIndexPic){
        return nil;
    }
    //头部视图origin无效,宽度无效,肯定是与table同宽
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kWindowW/750 * 500)];
    //添加底部视图
    UIView *botoomView = [UIView new];
    botoomView.backgroundColor = kRGBColor(240, 240, 240);
    [headView addSubview:botoomView];
    [botoomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    _titleLb = [UILabel new];
    [botoomView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = self.gameVM.indexPicNumber;
    [botoomView addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(60);
        make.width.mas_greaterThanOrEqualTo(20);
        make.left.mas_equalTo(_titleLb.mas_right).mas_equalTo(-10);
    }];
    _titleLb.text = [self.gameVM titleForRowInIndexPic:0];
    //添加滚动栏
    _ic = [iCarousel new];
    [headView addSubview:_ic];
    [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(botoomView.mas_top).mas_equalTo(0);
    }];
    _ic.delegate = self;
    _ic.dataSource = self;
    _ic.pagingEnabled = YES;
    _ic.scrollSpeed = 1;
    //如果只有一张图,则不显示圆点
    _pageControl.hidesForSinglePage = YES;
    //如果只有一张图,则不可以滚动
    _ic.scrollEnabled = self.gameVM.indexPicNumber != 1;
    _pageControl.pageIndicatorTintColor = [UIColor redColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    
    if (self.gameVM.indexPicNumber > 1) {
        _timer = [NSTimer bk_scheduledTimerWithTimeInterval:3 block:^(NSTimer *timer) {
            [_ic scrollToItemAtIndex:_ic.currentItemIndex+1 animated:YES];
        } repeats:YES];
    }
    //小圆点 不能与用户交互
    _pageControl.userInteractionEnabled = NO;
    return headView;
}
#pragma mark - iCarouselDataSource
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.gameVM.indexPicNumber;
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW/750 * 500 - 35)];
        UIImageView *imageView = [UIImageView new];
        [view addSubview:imageView];
        imageView.tag = 100;
        imageView.contentMode = 2;
        view.clipsToBounds = YES;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    UIImageView *imageView = (UIImageView *)[view viewWithTag:100];
    [imageView setImageWithURL:[self.gameVM iconURLForRowInIndexPic:index] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    return view;
}

#pragma mark - iCarouselDelegate
/** 允许循环滚动 */
-(CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}

/** 监控当前滚到到第几个 */
-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    //NSLog(@"%ld", carousel.currentItemIndex);
    _titleLb.text = [self.gameVM titleForRowInIndexPic:carousel.currentItemIndex];
    _pageControl.currentPage = carousel.currentItemIndex;
}

-(GameInfoViewModel *)gameVM
{
    if (!_gameVM) {
        _gameVM = [[GameInfoViewModel alloc] initWithType:_infoType];
    }
    return _gameVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[GameInfoListCell class] forCellReuseIdentifier:@"ListCell"];
    [self.tableView registerClass:[GameInfoImageCell class] forCellReuseIdentifier:@"ImageCell"];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.gameVM refreshDataCompletionHandle:^(NSError *error) {
            self.tableView.tableHeaderView = [self headerView];
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
        }];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.gameVM getMoreDataCompletionHandle:^(NSError *error) {
            self.tableView.tableHeaderView = [self headerView];
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];
        }];
    }];
    [self.tableView.header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gameVM.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.gameVM containImages:indexPath.row]) {
        GameInfoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
        cell.titleLb.text = [self.gameVM titleForRowInList:indexPath.row];
        cell.clicksNumLb.text = [self.gameVM clicksForRowInList:indexPath.row];
        [cell.iconIV0.imageView setImageWithURL:[self.gameVM iconURLSForRowInList:indexPath.row][0] placeholderImage:[UIImage imageNamed:@"xxxxx"]];
        [cell.iconIV1.imageView setImageWithURL:[self.gameVM iconURLSForRowInList:indexPath.row][1] placeholderImage:[UIImage imageNamed:@"xxxxx"]];
        [cell.iconIV2.imageView setImageWithURL:[self.gameVM iconURLSForRowInList:indexPath.row][2] placeholderImage:[UIImage imageNamed:@"xxxxx"]];
        return cell;
    }
    GameInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell" forIndexPath:indexPath];
    //placeholderImage当图片没有下载完成之前显示的图片
    [cell.iconIV.imageView setImageWithURL:[self.gameVM iconURLForRowInList:indexPath.row] placeholderImage:[UIImage imageNamed:@"xxxxx"]];
    cell.titleLb.text = [self.gameVM titleForRowInList:indexPath.row];
    cell.longTitleLb.text = [self.gameVM descForRowInList:indexPath.row];
    cell.clicksNumLb.text = [self.gameVM clicksForRowInList:indexPath.row];
    return cell;
}
/** 去掉分割线左侧缝隙 */
kRemoveCellSeparator

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.gameVM isHtmlInListForRow:indexPath.row]) {
        GameInfoHtmlViewController *vc=[[GameInfoHtmlViewController alloc] initWithURL:[self.gameVM detailURLForRowInList:indexPath.row]];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([self.gameVM isPicInListForRow:indexPath.row]) {
        GameInfoPicViewController *vc =[[GameInfoPicViewController alloc] initWithAid:[self.gameVM aidInListForRow:indexPath.row]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


/** 滚动栏中被选中后触发 */
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if ([self.gameVM isHtmlInIndexPicForRow:index]) {
        GameInfoHtmlViewController *vc=[[GameInfoHtmlViewController alloc] initWithURL:[self.gameVM detailURLForRowInIndexPic:index]];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([self.gameVM isPicInIndexPicForRow:index]) {
        GameInfoPicViewController *vc=[[GameInfoPicViewController alloc] initWithAid:[self.gameVM aidInIndexPicForRow:index]];
        //  获取成员变量, 外部不可以获取保护 和 私有类型
        //  如果是继承， 继承公开和保护的， 私有的不可以
        vc->public1= @",,,,";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.gameVM containImages:indexPath.row]? 135 : 90;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
