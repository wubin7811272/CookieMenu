//
//  MenuListViewController.h
//  CookMenu
//
//  Created by Sincere on 15/5/2.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuListViewController : UIViewController
@property(nonatomic,assign)BOOL isSearch;

@property(nonatomic,copy)NSString *classTitle;
@property(nonatomic,copy)NSString *sqlStr;
@property(nonatomic,strong)NSArray *classArr;//分类的数组
@property(nonatomic,strong)NSArray *sqlArr;//sql语句数组
@end
