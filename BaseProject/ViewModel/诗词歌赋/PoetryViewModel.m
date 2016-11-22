//
//  PoetryViewModel.m
//  BaseProject
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoetryViewModel.h"
#import "PoetryModel.h"

@implementation PoetryViewModel
- (id)initWithKind:(NSString *)kind{
    if (self = [super init]) {
        _kind = kind;
    }
    return self;
}

- (NSInteger)rowNumber{
    return self.poetryList.count;
}

- (PoetryModel *)poetryModelForRow:(NSInteger)row{
    return self.poetryList[row];
}

- (NSArray *)poetryList{
    return [PoetryModel poetryListWithKind:_kind];
}

- (NSString *)titleForRow:(NSInteger)row{
    return [self poetryModelForRow:row].title;
}

- (NSString *)authorForRow:(NSInteger)row{
    return [self poetryModelForRow:row].author;
}

- (NSString *)shiForRow:(NSInteger)row{
    return [self poetryModelForRow:row].shi;
}

- (NSString *)shiIntroForRow:(NSInteger)row{
    return [self poetryModelForRow:row].introShi;
}

- (BOOL)removePoetryForRow:(NSInteger)row{
    return [[self poetryModelForRow:row] removePoetry];
}
@end
