//
//  GameInfoPicViewModel.h
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "GameInfoNetManager.h"

@interface GameInfoPicViewModel : BaseViewModel

/** 必须使用下方初始化方法 */
- (id)initWithAid:(NSString *)aid;
/** aid的赋值应该是非空,使用xcode7新加入的非空标识 */
@property(nonatomic,strong) NSString *aid;
@property(nonatomic) NSInteger rowNumber;
- (NSURL *)picURLForRow:(NSInteger)row;
@property(nonatomic,strong) GameInfoPicModel * picModel;

@end
