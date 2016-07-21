//
//  GameInfoModel.m
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "GameInfoModel.h"

@implementation GameInfoModel

@end

@implementation GameInfoDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"indexpic" : [GameInfoDataIndexpicModel class], @"list" : [GameInfoDataIndexpicModel class]};
}

@end


@implementation GameInfoDataIndexpicModel

+ (NSDictionary *)objectClassInArray{
    return @{@"showitem" : [GameInfoDataIndexpicShowitemModel class]};
}

@end


@implementation GameInfoDataIndexpicInfochildModel

@end


@implementation GameInfoDataIndexpicShowitemModel

@end


@implementation GameInfoDataIndexpicShowitemInfoModel

@end
