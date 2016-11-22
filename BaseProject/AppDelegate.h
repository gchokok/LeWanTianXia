//
//  AppDelegate.h
//  BaseProject
//
//  Created by gaochen on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RESideMenu;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong) RESideMenu *sideMenu;
@property(nonatomic,getter=isOnLine) BOOL onLine; //网络状态
@end

