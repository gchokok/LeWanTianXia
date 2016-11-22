//
//  VideoCell.m
//  BaseProject
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "VideoCell.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@implementation VideoCell

+ (AVPlayerViewController *)standardInstance{
    static AVPlayerViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [AVPlayerViewController new];
    });
    return vc;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(self.descLb.mas_top).mas_equalTo(-5);
        }];
    }
    return _titleLb;
}

- (UILabel *)descLb {
    if(_descLb == nil) {
        _descLb = [[UILabel alloc] init];
        _descLb.font = [UIFont systemFontOfSize:15];
        _descLb.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_descLb];
        [_descLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_equalTo(5);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(self.playLB.mas_top).mas_equalTo(-10);
        }];
    }
    return _descLb;
}

- (UIButton *)iconBtn {
    if(_iconBtn == nil) {
        _iconBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_iconBtn];
        [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.playLB.mas_bottom).mas_equalTo(10);
            make.right.bottom.mas_equalTo(-10);
        }];
        [_iconBtn bk_addEventHandler:^(id sender) {
            AVPlayer *player=[AVPlayer playerWithURL:self.videoURL];
            [player play];
            [VideoCell standardInstance].player = player;
            [sender addSubview:[VideoCell standardInstance].view];
            [[VideoCell standardInstance].view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconBtn;
}

- (UILabel *)playLB {
    if(_playLB == nil) {
        _playLB = [[UILabel alloc] init];
        [self.contentView addSubview:_playLB];
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sound_play"]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.descLb.mas_bottom).mas_equalTo(10);
            make.bottom.mas_equalTo(self.iconBtn.mas_top).mas_equalTo(-10);
        }];
        [_playLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageView);
            make.left.mas_equalTo(imageView.mas_right).mas_equalTo(3);
        }];
        _playLB.textColor = [UIColor lightGrayColor];
        _playLB.font = [UIFont systemFontOfSize:12];
    }
    return _playLB;
}

- (UILabel *)timeLB {
    if(_timeLB == nil) {
        _timeLB = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLB];
        [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.playLB);
            make.width.mas_equalTo(150);
        }];
        _timeLB.textAlignment = 2;
        _timeLB.textColor = [UIColor lightGrayColor];
        _timeLB.font = [UIFont systemFontOfSize:12];
    }
    return _timeLB;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    if ([VideoCell standardInstance].view.superview == self.iconBtn) {
        [[VideoCell standardInstance].view removeFromSuperview];
        [VideoCell standardInstance].player = nil;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
