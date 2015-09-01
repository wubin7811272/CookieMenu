//
//  FoodDataCell.h
//  CookMenu
//
//  Created by mac on 15/5/6.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodDataCell : UITableViewCell
@property(nonatomic,assign)CGFloat foodDataTableRowHeight;
- (void)loadingFoodDataWithDict:(NSDictionary *)dataDict;
@end
