//
//  WBExpandHeader.h
//  CookMenu
//
//  Created by mac on 15/5/4.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WBExpandHeader : NSObject<UIScrollViewDelegate>
+ (id)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;
@end
