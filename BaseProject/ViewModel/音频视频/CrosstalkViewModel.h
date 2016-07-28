//
//  CrosstalkViewModel.h
//  BaseProject
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface CrosstalkViewModel : BaseViewModel
@property(nonatomic) NSInteger rowNumber;
@property(nonatomic) NSInteger pageId;
@property(nonatomic) NSInteger maxPageId;
@property(nonatomic, getter=isHasMore) BOOL hasMore;

- (NSURL *)audioURLForRow:(NSInteger)row;
- (NSURL *)imageURLForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)durationForRow:(NSInteger)row;
- (NSString *)likesForRow:(NSInteger)row;
- (NSString *)playtimesForRow:(NSInteger)row;

@end
