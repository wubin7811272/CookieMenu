//
//  MenuCell.h
//  CookMenu
//
//  Created by Sincere on 15/5/1.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MenuCellDelegate;
@interface MenuCell : UITableViewCell
@property(nonatomic,assign)CGFloat cellRowHeight;
@property(nonatomic,assign)id<MenuCellDelegate>delegate;
- (void)loadCookMenuWithArr:(NSArray *)array selectBtnIdex:(NSInteger)index;
@end

@protocol MenuCellDelegate <NSObject>
@optional
- (void)didSelectMenuWithIndex:(NSInteger)index;
@end