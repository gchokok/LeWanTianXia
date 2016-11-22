//
//  KindViewModel.m
//  BaseProject
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "KindViewModel.h"
#import "KindModel.h"

@implementation KindViewModel

- (NSInteger)rowNumber{
    return self.kinds.count;
}
- (NSArray *)kinds{
    return [KindModel kinds];
}
- (KindModel *)kindModelForRow:(NSInteger)row{
    return self.kinds[row];
}
- (NSString *)titleForRow:(NSInteger)row{
    return [self kindModelForRow:row].kind;
}
- (NSString *)detailForRow:(NSInteger)row{
    return [self kindModelForRow:row].introKind;
}
- (BOOL)hasDetailForRow:(NSInteger)row{
    return [self detailForRow:row].length != 0;
}
- (BOOL)removeKindForRow:(NSInteger)row{
    return [[self kindModelForRow:row] removeKind];
}
@end
