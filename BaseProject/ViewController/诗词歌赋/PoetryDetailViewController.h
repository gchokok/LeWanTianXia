//
//  PoetryDetailViewController.h
//  BaseProject
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoetryDetailViewController : UIViewController
-(id)initWithShi:(NSString *)shi intro:(NSString *)shiIntro;
@property(nonatomic,strong) NSString *shi;
@property(nonatomic,strong) NSString *shiIntro;

@end
