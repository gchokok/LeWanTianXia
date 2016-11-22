//
//  GameInfoListViewController.h
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameInfoListViewController : UITableViewController
/** 接收外部传参，决定当前控制器显示哪种类型的信息 */
@property(nonatomic) NSUInteger infoType;

@end
