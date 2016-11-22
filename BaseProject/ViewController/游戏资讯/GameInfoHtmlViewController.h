//
//  GameInfoHtmlViewController.h
//  BaseProject
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameInfoHtmlViewController : UIViewController

- (id)initWithURL:(NSURL *)url;
@property(nonatomic,strong) NSURL *url;
@end
