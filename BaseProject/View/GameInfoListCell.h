//
//  GameInfoListCell.h
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRImageView.h"
@interface GameInfoListCell : UITableViewCell
//* 左侧图片 */
@property(nonatomic,strong)TRImageView *iconIV;
//* 题目标签 */
@property(nonatomic,strong)UILabel *titleLb;
//* 长题目标签 */
@property(nonatomic,strong)UILabel *longTitleLb;
//* 点击数标签 */
@property(nonatomic,strong)UILabel *clicksNumLb;
@end
