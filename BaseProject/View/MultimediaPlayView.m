//
//  MultimediaPlayView.m
//  BaseProject
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MultimediaPlayView.h"

@implementation MultimediaPlayView
+(MultimediaPlayView *)sharedInstance{
    static MultimediaPlayView *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [MultimediaPlayView new];
    });
    return view;
}

- (id)init{
    if (self = [super init]) {
        self.playBtn.hidden = YES;
    }
    return self;
}

- (UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn =[UIButton buttonWithType:0];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"toolbar_play_n_p"] forState:UIControlStateNormal];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"toolbar_pause_n_p"] forState:UIControlStateSelected];
        [self addSubview:_playBtn];
        [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_playBtn bk_addEventHandler:^(UIButton *sender) {
            //selected YES:在播放  NO：暂停
            if (sender.selected) {
                [_player pause];
            }else{
                [_player play];
            }
            sender.selected = !sender.selected;
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (void)playWithURL:(NSURL *)musicURL{
    //设置支持的类别
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    //激活
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    _player =[AVPlayer playerWithURL:musicURL];
    [_player play];
    self.playBtn.selected = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
