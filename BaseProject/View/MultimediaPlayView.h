//
//  MultimediaPlayView.h
//  BaseProject
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MultimediaPlayView : UIView
+ (MultimediaPlayView *)sharedInstance;
- (void)playWithURL:(NSURL *)musicURL;
@property(nonatomic, strong) AVPlayer *player;
@property(nonatomic, strong) UIButton *playBtn;
@end
