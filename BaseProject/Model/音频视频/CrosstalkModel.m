//
//  CrosstalkModel.m
//  BaseProject
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CrosstalkModel.h"

@implementation CrosstalkModel

@end

@implementation CrosstalkAlbumModel

@end

@implementation CrosstalkTracksModel
//需要告诉他 List数组中的元素 由哪个类解析
+ (NSDictionary *)objectClassInArray{
    return @{@"list": [CrosstalkTracksListModel class]};
}

@end

@implementation CrosstalkTracksListModel

@end
