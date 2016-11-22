//
//  KindViewModel.h
//  BaseProject
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface KindViewModel : BaseViewModel

@property(nonatomic) NSInteger rowNumber;
@property(nonatomic,strong) NSArray *kinds;

- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)detailForRow:(NSInteger)row;
- (BOOL)hasDetailForRow:(NSInteger)row;
- (BOOL)removeKindForRow:(NSInteger)row;

@end
