//
//  SearchPoetryViewModel.m
//  BaseProject
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SearchPoetryViewModel.h"
#import "PoetryModel.h"
@implementation SearchPoetryViewModel
-(id)initWithIndex:(NSInteger)index{
    if (self = [super init]) {
        _index = index;
    }
    return self;
}

-(NSArray *)poetryList{
    if (_searchStr == nil || _searchStr.length == 0) {
        return nil;
    }
    return [PoetryModel poetryListWithSearchStr:_searchStr Index:_index];
}
@end
