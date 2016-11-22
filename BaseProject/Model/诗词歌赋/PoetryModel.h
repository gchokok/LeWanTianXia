//
//  PoetryModel.h
//  BaseProject
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface PoetryModel : BaseModel
@property(nonatomic,strong) NSString *kind;
@property(nonatomic,strong) NSString *shi;
@property(nonatomic,strong) NSString *introShi;
@property(nonatomic,strong) NSString *title;
@property(nonatomic) long ID;
@property(nonatomic,strong) NSString *author;

+ (NSArray *)poetryListWithKind:(NSString *)kind;
//通过字符串，搜索 诗名或者作者包含此字符串的诗
+ (NSArray *)poetryListWithSearchStr:(NSString *)searchStr Index:(NSInteger)index;

- (BOOL)removePoetry;
@end
