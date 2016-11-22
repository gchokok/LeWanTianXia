//
//  SearchPoetryViewModel.h
//  BaseProject
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoetryViewModel.h"

@interface SearchPoetryViewModel : PoetryViewModel
- (id)initWithIndex:(NSInteger)index;
@property(nonatomic) NSInteger index;
@property(nonatomic,strong) NSString *searchStr;

@end
