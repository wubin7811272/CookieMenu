//
//  MenuDetailViewController.h
//  CookMenu
//
//  Created by Sincere on 15/5/2.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeModel.h"
@interface MenuDetailViewController : UIViewController
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,copy)NSString *titlePicStr;
@property(nonatomic,strong)NSDictionary *authorDict;
@property(nonatomic,strong)NSDictionary *liaosDict;
@property(nonatomic,strong)NSArray *detailArr;
@property(nonatomic,strong)RecipeModel *recipe;
@end
