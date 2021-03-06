//
//  BestGroupViewModel.h
//  BaseProject
//
//  Created by gaochen on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "LOLNetManager.h"

//总要拼接，做宏
#define kIconPathWithEnName(enName)  [NSString stringWithFormat:@"http://img.lolbox.duowan.com/champions/%@_120x120.jpg", enName]

@interface BestGroupViewModel : BaseViewModel

@property(nonatomic) NSInteger rowNumber;
/** 英雄头像URL数组 */
- (NSArray *)iconURLsForRow:(NSInteger)row;

- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)descForRow:(NSInteger)row;

/** 英雄描述数组 */
- (NSArray *)descsForRow:(NSInteger)row;

@end

















