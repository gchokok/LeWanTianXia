//
//  MultimediaTabBarController.m
//  BaseProject
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MultimediaTabBarController.h"
#import "MusicViewController.h"
#import "VideoViewController.h"
#import "CrosstalkViewController.h"

@interface MultimediaTabBarController ()

@end

@implementation MultimediaTabBarController

+ (MultimediaTabBarController *)standardInstance{
    static MultimediaTabBarController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [MultimediaTabBarController new];
    });
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    MusicViewController *musicVC = [MusicViewController new];
    VideoViewController *videoVC = [VideoViewController new];
    CrosstalkViewController *crossVC = [CrosstalkViewController new];
    UINavigationController *musicNavi = [[UINavigationController alloc]initWithRootViewController:musicVC];
    UINavigationController *videoNavi = [[UINavigationController alloc]initWithRootViewController:videoVC];
    UINavigationController *crossNavi = [[UINavigationController alloc]initWithRootViewController:crossVC];
    self.viewControllers = @[musicNavi,videoNavi,crossNavi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
