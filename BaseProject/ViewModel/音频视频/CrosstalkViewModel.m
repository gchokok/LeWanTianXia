//
//  CrosstalkViewModel.m
//  BaseProject
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CrosstalkViewModel.h"
#import "MultimediaNetManager.h"

@implementation CrosstalkViewModel
- (NSInteger)rowNumber{
    return self.dataArr.count;
}

- (BOOL)isHasMore{
    return _maxPageId > _pageId;
}

-(CrosstalkTracksListModel *)listModelForRow:(NSInteger)row{
    return self.dataArr[row];
}

-(NSURL *)audioURLForRow:(NSInteger)row{
    NSString *path=[self listModelForRow:row].playUrl64;
    return [NSURL URLWithString:path];
}

- (NSURL *)imageURLForRow:(NSInteger)row{
    NSString *path=[self listModelForRow:row].coverSmall;
    return [NSURL URLWithString:path];
}
- (NSString *)titleForRow:(NSInteger)row{
    return [self listModelForRow:row].title;
}

- (NSString *)durationForRow:(NSInteger)row{
    NSInteger duration=[self listModelForRow:row].duration;
    NSInteger minute= duration/60;
    NSInteger second = duration%60;
    return [NSString stringWithFormat:@"%02ld:%02ld", minute, second];
}

- (NSString *)likesForRow:(NSInteger)row{
    return @([self listModelForRow:row].likes).stringValue;
}

- (NSString *)playtimesForRow:(NSInteger)row{
    return @([self listModelForRow:row].playtimes).stringValue;
}

- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle{
    _pageId = 1;
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle{
    if (self.isHasMore) {
        _pageId += 1;
        [self getDataFromNetCompleteHandle:completionHandle];
    }else{
        NSError *error =[NSError errorWithDomain:@"" code:999 userInfo:@{NSLocalizedDescriptionKey: @"没有更多数据"}];
        completionHandle(error);
    }
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    self.dataTask=[MultimediaNetManager getCrosstalkWithPageId:_pageId completionHandle:^(CrosstalkModel *model, NSError *error) {
        if (_pageId == 1) {
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:model.tracks.list];
        _maxPageId = [model.tracks.maxPageId integerValue];
        completionHandle(error);
    }];
}

@end
