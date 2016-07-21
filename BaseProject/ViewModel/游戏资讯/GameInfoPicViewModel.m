//
//  GameInfoPicViewModel.m
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "GameInfoPicViewModel.h"
#import "GameInfoNetManager.h"

@implementation GameInfoPicViewModel

- (id)initWithAid:(NSString *)aid{
    if (self = [super init]) {
        self.aid = aid;
    }
    return self;
}
/** 防御性编程，不允许使用init初始化 */
- (id)init{
    if (self = [super init]) {
        //%s->__func__  会显示 哪个类中的哪个方法
        NSAssert1(NO, @"%s 必须使用initWithAid初始化", __func__);
    }
    return self;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    self.dataTask = [GameInfoNetManager getPicDetailWithId:_aid completionHandle:^(GameInfoPicModel *model, NSError *error) {
        self.picModel = model;
        completionHandle(error);
    }];
}
- (NSInteger)rowNumber{
    return self.picModel.content.count;
}
- (NSURL *)picURLForRow:(NSInteger)row{
    GameInfoPicContentModel *model = self.picModel.content[row];
    return [NSURL URLWithString:model.pic];
}

@end
