//
//  LOLNetManager.h
//  BaseProject
//
//  Created by apple on 16/7/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "LOLModel.h"

@interface LOLNetManager : BaseNetManager

+ (id)getToolMenuCompletionHandle:(void (^)(id, NSError *))completionHandle;

+ (id)getZBCategoryCompletionHandle:(void (^)(id, NSError *))completionHandle;

+ (id)getZBItemListWithTag:(NSString *)tag kCompletionHandle;

+ (id)getSumAbilityCompletionHandle:(void (^)(id, NSError *))completionHandle;

+ (id)getHeroBestGroupCompletionHandle:(void (^)(id, NSError *))completionHandle;
@end
