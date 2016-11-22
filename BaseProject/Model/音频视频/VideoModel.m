//
//  VideoModel.m
//  BaseProject
//
//  Created by gaochen on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

+ (NSDictionary *)objectClassInArray{
    return @{@"videoSidList":[VideoVideoSidListModel class],
             @"videoList": [VideoVideoListModel class]};
}

@end

@implementation VideoVideoListModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"desc": @"description",
             @"m3u8Url": @"m3u8_url",
             @"m3u8HdUrl":@"m3u8Hd_url",
             @"mp4Url":@"mp4_url",
             @"mp4HdUrl":@"mp4Hd_url"
             };
}

@end

@implementation VideoVideoSidListModel

@end










