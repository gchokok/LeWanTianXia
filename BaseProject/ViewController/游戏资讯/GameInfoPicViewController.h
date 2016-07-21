//
//  GameInfoPicViewController.h
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameInfoPicViewController : UIViewController
{
@private //私有
    NSString *private1;
@protected  //保护--默认是保护
    NSString *protected1;
@public     //共有
    NSString *public1;
}
/** 此界面内容要根据aid来决定，所以aid是必须的 */
- (id _Nonnull)initWithAid:(NSString * _Nonnull )aid;
@property(nonatomic,strong) NSString * _Nonnull aid;

@end
