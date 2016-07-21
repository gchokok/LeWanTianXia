//
//  GameInfoImageCell.h
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRImageView.h"

@interface GameInfoImageCell : UITableViewCell
/** 题目标签 */
@property(nonatomic,strong)UILabel *titleLb;
/** 点击数标签 */
@property(nonatomic,strong)UILabel *clicksNumLb;
/** 图片1 */
@property(nonatomic,strong)TRImageView *iconIV0;
/** 图片2 */
@property(nonatomic,strong)TRImageView *iconIV1;
/** 图片3 */
@property(nonatomic,strong)TRImageView *iconIV2;

@end
