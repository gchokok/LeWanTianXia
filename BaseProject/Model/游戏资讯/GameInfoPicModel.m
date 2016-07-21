//
//  GameInfoPicModel.m
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "GameInfoPicModel.h"

@implementation GameInfoPicModel
+ (NSDictionary *)objectClassInArray{
    return @{@"showitem" : [GameInfoPicShowitemModel class], @"relevant" : [GameInfoPicRelevantModel class], @"content" : [GameInfoPicContentModel class]};
}
@end
@implementation GameInfoPicInfochildModel

@end


@implementation GameInfoPicShowitemModel

@end


@implementation GameInfoPicShowitemInfoModel

@end


@implementation GameInfoPicRelevantModel

@end


@implementation GameInfoPicContentModel

@end


@implementation GameInfoPicContentInfoModel

@end
