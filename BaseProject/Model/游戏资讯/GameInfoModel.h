//
//  GameInfoModel.h
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class GameInfoDataModel,GameInfoDataIndexpicModel,GameInfoDataIndexpicInfochildModel,GameInfoDataIndexpicShowitemModel,GameInfoDataIndexpicShowitemInfoModel;
@interface GameInfoModel : BaseModel

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) GameInfoDataModel *data;

@property (nonatomic, copy) NSString *code;

@end
@interface GameInfoDataModel : BaseModel

@property (nonatomic, strong) NSArray<GameInfoDataIndexpicModel *> *indexpic;

@property (nonatomic, strong) NSArray<GameInfoDataIndexpicModel *> *list;

@end

@interface GameInfoDataIndexpicModel : BaseModel

@property (nonatomic, copy) NSString *color;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *showtype;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *click;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *typechild;

@property (nonatomic, copy) NSString *longtitle;

@property (nonatomic, copy) NSString *typeName;

@property (nonatomic, copy) NSString *html5;

@property (nonatomic, copy) NSString *toutiao;

@property (nonatomic, strong) GameInfoDataIndexpicInfochildModel *infochild;

@property (nonatomic, copy) NSString *litpic;

@property (nonatomic, copy) NSString *aid;

@property (nonatomic, assign) NSInteger pictotal;

@property (nonatomic, strong) NSArray<GameInfoDataIndexpicShowitemModel *> *showitem;

@property (nonatomic, copy) NSString *pubdate;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic, copy) NSString *murl;

@property (nonatomic, copy) NSString *banner;

@property (nonatomic, copy) NSString *zangs;

@property (nonatomic, copy) NSString *writer;

@property (nonatomic, copy) NSString *timer;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *desc;

@end

@interface GameInfoDataIndexpicInfochildModel : BaseModel

@property (nonatomic, copy) NSString *later;

@property (nonatomic, copy) NSString *cn;

@property (nonatomic, copy) NSString *facial;

@property (nonatomic, copy) NSString *feature;

@property (nonatomic, copy) NSString *role;

@property (nonatomic, copy) NSString *shoot;

@end

@interface GameInfoDataIndexpicShowitemModel : BaseModel

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) GameInfoDataIndexpicShowitemInfoModel *info;

@end

@interface GameInfoDataIndexpicShowitemInfoModel : BaseModel

@property (nonatomic, copy) NSString *width;

@property (nonatomic, assign) NSInteger height;

@end
