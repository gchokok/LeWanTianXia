//
//  GameInfoNetManager.h
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "GameInfoModel.h"
#import "GameInfoPicModel.h"

typedef NS_ENUM(NSUInteger, InfoType) {
    InfoTypeTouTiao,        //头条
    InfoTypeDuJia,          //独家
    InfoTypeAnHei3,         //暗黑3
    InfoTypeMoShou,         //魔兽
    InfoTypeFengBao,        //风暴
    InfoTypeLuShi,          //炉石
    InfoTypeXingJi2,        //星际2
    InfoTypeShouWang,       //守望
    InfoTypeTuPian,         //图片
    InfoTypeGongLue,        //攻略
    InfoTypeHuanHua,        //幻化
    InfoTypeQuWen,          //趣闻
    InfoTypeCos,            //COS
    InfoTypeMeiNv,          //美女
};

@interface GameInfoNetManager : BaseNetManager

+ (id)getGameInfoWithType:(InfoType)type start:(NSInteger)start kCompletionHandle;

+ (id)getPicDetailWithId:(NSString *)aid kCompletionHandle;
@end
