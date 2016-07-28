//
//  MusicListViewController.h
//  BaseProject
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicListViewController : UIViewController
- (id)initWithAlbumId:(NSInteger)albumId;
@property(nonatomic) NSInteger albumId;

@end
