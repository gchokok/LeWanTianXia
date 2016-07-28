//
//  LOLTabBarController.m
//  BaseProject
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "LOLTabBarController.h"

@interface LOLTabBarController ()

@end

@implementation LOLTabBarController
+ (LOLTabBarController *)standardInstance{
    static LOLTabBarController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [LOLTabBarController new];
    });
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
