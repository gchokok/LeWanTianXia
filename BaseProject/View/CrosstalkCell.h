//
//  CrosstalkCell.h
//  BaseProject
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRImageView.h"

@interface CrosstalkCell : UITableViewCell
@property(nonatomic,strong) TRImageView *coverIV;
@property (nonatomic,strong) UILabel *titleLb;
@property(nonatomic,strong) UILabel *playtimesLb;
@property(nonatomic,strong) UILabel *likesLb;
@property(nonatomic,strong) UILabel *durationLb;

@end
