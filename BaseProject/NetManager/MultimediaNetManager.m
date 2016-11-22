//
//  MultimediaNetManager.m
//  BaseProject
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MultimediaNetManager.h"

#define kRankListPath       @"http://mobile.ximalaya.com/mobile/discovery/v1/rankingList/album"
#define kAlbumPath          @"http://mobile.ximalaya.com/mobile/others/ca/album/track/%@/true/%@/20"
#define kCrosstalkPath      @"http://mobile.ximalaya.com/mobile/others/ca/album/track/238474/true/%@/20?device=iPhone"
#define kVideoPath          @"http://c.m.163.com/nc/video/home/%@-10.html"

@implementation MultimediaNetManager

+ (id)getRankListWithPageId:(NSInteger)pageId completionHandle:(void (^)(id, NSError *))completionHandle{
    NSDictionary *params = @{@"device":@"iPhone", @"key":@"ranking:album:played:1:2", @"pageId":@(pageId), @"pageSize": @20, @"position": @0, @"title": @"排行榜"};
    return [self GET:kRankListPath parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([RankingListModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getAlbumWithId:(NSInteger)ID page:(NSInteger)pageId completionHandle:(void (^)(id, NSError *))completionHandle{
    //  %@  已经拼入 宏定义 kAlbumPath 中
    NSString *path = [NSString stringWithFormat:kAlbumPath, @(ID), @(pageId)];
    return [self GET:path parameters:@{@"device": @"iPhone"} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([AlbumModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getCrosstalkWithPageId:(NSInteger)pageId completionHandle:(void (^)(id, NSError *))completionHandle{
    NSString *path = [NSString stringWithFormat:kCrosstalkPath, @(pageId)];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([CrosstalkModel objectWithKeyValues:responseObj],error);
    }];
}

+ (id)getVideoWithIndex:(NSInteger)index completionHandle:(void (^)(id, NSError *))completionHandle{
    NSString *path=[NSString stringWithFormat:kVideoPath, @(index)];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([VideoModel objectWithKeyValues:responseObj], error);
    }];
}

@end
