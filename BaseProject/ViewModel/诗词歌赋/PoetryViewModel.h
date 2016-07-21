//
//  PoetryViewModel.h
//  BaseProject
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface PoetryViewModel : BaseViewModel

- (id)initWithKind:(NSString *)kind;
@property(nonatomic,strong) NSString *kind;
@property(nonatomic) NSInteger rowNumber;
@property(nonatomic,strong) NSArray *poetryList;

- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)authorForRow:(NSInteger)row;
- (NSString *)shiForRow:(NSInteger)row;
- (NSString *)shiIntroForRow:(NSInteger)row;
- (BOOL)removePoetryForRow:(NSInteger)row;
@end
