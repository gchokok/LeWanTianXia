//
//  PoetryListViewController.h
//  BaseProject
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoetryListViewController : UIViewController
- (id)initWithKind:(NSString *)kind;

@property(nonatomic,strong) NSString *kind;
@end

@interface PoetryListCell : UITableViewCell
@end