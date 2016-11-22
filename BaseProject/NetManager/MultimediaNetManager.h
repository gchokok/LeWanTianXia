//
//  MultimediaNetManager.h
//  BaseProject
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "MultimediaModel.h"

@interface MultimediaNetManager : BaseNetManager

/**
 *  获取音乐分类列表
 *
 *  @param pageId 当前页数从1开始. eg 1,2,3,4,5...
 *
 *  @return 返回当前请求所在的任务
 */

+ (id)getRankListWithPageId:(NSInteger)pageId kCompletionHandle;

/**
 *  获取音乐内容列表
 *
 *  @param ID     音乐组ID
 *  @param pageId 当前页数，从1开始 eg 1,2,3,4,5...
 *
 *  @return 返回当前请求所在任务
 */

+ (id)getAlbumWithId:(NSInteger)ID page:(NSInteger)pageId kCompletionHandle;

/**
 *  获取相声内容列表
 *
 *  @param pageId 当前页数
 *
 *  @return 返回当前请求所在任务
 */
+ (id)getCrosstalkWithPageId:(NSInteger)pageId kCompletionHandle;

/**
 *  获取视频内容列表
 *
 *  @param index 当前项
 *
 *  @return 返回当前请求所在任务
 */
+ (id)getVideoWithIndex:(NSInteger)index kCompletionHandle;

@end
