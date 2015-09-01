//
//  MenuListCell.h
//  CookMenu
//
//  Created by Sincere on 15/5/2.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeModel.h"
@interface MenuListCell : UITableViewCell
- (void)loadingMenuListWith:(RecipeModel *)recipe;
@end
