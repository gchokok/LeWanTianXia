//
//  VideoCell.h
//  BaseProject
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCell : UITableViewCell
@property(nonatomic,strong) UILabel *titleLb;
@property(nonatomic,strong) UILabel *descLb;
@property(nonatomic,strong) UIButton *iconBtn;
@property(nonatomic,strong) UILabel *playLB;
@property(nonatomic,strong) UILabel *timeLB;
@property(nonatomic,strong) UIButton *playBtn;
@property(nonatomic,strong) NSURL *videoURL;

@end
