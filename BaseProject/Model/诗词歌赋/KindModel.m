//
//  KindModel.m
//  BaseProject
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "KindModel.h"

@implementation KindModel

+ (NSArray *)kinds{
    FMDatabase *db = [self defaultDatabase];
    FMResultSet *rs = [db executeQuery:@"select * from T_KIND"];
    NSMutableArray *dataArr = [NSMutableArray new];
    while ([rs next]) {
        KindModel *model = [self new];
        model.kind = [rs stringForColumn:@"D_KIND"];
        model.num = [rs longForColumn:@"D_NUM"];
        model.introKind = [rs stringForColumn:@"D_INTROKIND"];
        model.introKind2 = [rs stringForColumn:@"D_INTROKIND2"];
        [dataArr addObject:model];
    }
    [db closeOpenResultSets];
    [db close];
    return [dataArr copy];
    
}

- (BOOL)removeKind{
    FMDatabase *db = [KindModel defaultDatabase];
    BOOL success=[db executeUpdateWithFormat:@"delete from t_kind where D_KIND = %@", _kind];
    [db close];
    return success;
}

@end
