//
//  MenuDetailCell.h
//  CookMenu
//
//  Created by Sincere on 15/5/3.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuDetailCell : UITableViewCell
@property(nonatomic,assign)CGFloat detailTableRowHeight;
- (void)loadingDetailMenuWithDict:(NSDictionary *)detailDict;
@end
