//
//  KindModel.h
//  BaseProject
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface KindModel : BaseModel

@property(nonatomic,strong) NSString *kind;
@property(nonatomic,strong) NSString *introKind;
@property(nonatomic,strong) NSString *introKind2;
@property(nonatomic) long num;

+ (NSArray *)kinds;

- (BOOL)removeKind;

@end
