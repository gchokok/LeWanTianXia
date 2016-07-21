//
//  PoetryModel.m
//  BaseProject
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoetryModel.h"

@implementation PoetryModel
//把搜索结果FMResultSet类型转换为 包含PoetryModel的数组类型
+ (NSArray *)rsToPortryList:(FMResultSet *)rs{
    NSMutableArray *dataArr = [NSMutableArray new];
    while ([rs next]) {
        PoetryModel *model = [self new];
        model.kind = [rs stringForColumn:@"d_kind"];
        model.author=[rs stringForColumn:@"d_author"];
        model.title=[rs stringForColumn:@"d_title"];
        model.ID = [rs longForColumn:@"d_id"];
        model.shi = [rs stringForColumn:@"d_shi"];
        model.introShi=[rs stringForColumn:@"d_introshi"];
        [dataArr addObject:model];
    }
    return [dataArr copy];
}

- (BOOL)removePoetry{
    FMDatabase *db = [PoetryModel defaultDatabase];
    BOOL success = [db executeUpdateWithFormat:@"delete from t_shi where d_id = %ld", _ID];
    [db close];
    return success;
}

+ (NSArray *)poetryListWithKind:(NSString *)kind{
    FMDatabase *db = [self defaultDatabase];
    //如果数据库语句需要传参 要用executeQueryWithFormat
    FMResultSet *rs = [db executeQueryWithFormat:@"select * from T_SHI where d_kind = %@", kind];
    NSArray *arr = [self rsToPortryList:rs];
    [db close];
    return arr;
}

+ (NSArray *)poetryListWithSearchStr:(NSString *)searchStr Index:(NSInteger)index{
    FMDatabase *db = [self defaultDatabase];
    //SQL语句 通配符%  ss ->  %ss%
    //如果要在format中输入%，需要转义符%配合
    searchStr=[NSString stringWithFormat:@"%%%@%%", searchStr];
    //DDLogVerbose(@"searchStr: %@", searchStr);
    FMResultSet *rs = nil;
    if (index == 0) {
        rs = [db executeQueryWithFormat:@"select * from t_shi where d_title like %@", searchStr];
    }
    if (index == 1) {
        rs = [db executeQueryWithFormat:@"select * from t_shi where d_author like %@", searchStr];
    }
    NSArray *arr = [self rsToPortryList:rs];
    [db close];
    return arr;
}

@end
