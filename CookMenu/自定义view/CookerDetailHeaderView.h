//
//  CookerDetailHeaderView.h
//  CookMenu
//
//  Created by mac on 15/5/4.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CookerDetailHeaderView : UITableViewHeaderFooterView
/*!菜名*/
@property (nonatomic, strong) UILabel           *dishNameLable;



@property (nonatomic,assign)CGFloat headerViewHeight;

- (void)loadUIWithDictionary:(NSDictionary *)liaosDict;
@end
