//
//  CookMenu_Header.h
//  CookMenu
//
//  Created by Sincere on 15/5/1.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#ifndef CookMenu_CookMenu_Header_h
#define CookMenu_CookMenu_Header_h


#endif

#import "UILabel+SizeLabel.h"
#import "UIColor+WTRequestCenter.h"
#import "UIScreen+WTRequestCenter.h"
#import "UIImageView+WebCache.h"
#import "DBManager.h"
#import "SVProgressHUD.h"
#import "NSString+manageString.h"

#define   HISTORY_SEARCH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/historySearch.plist"]

#define   FAVORITE [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/favorite.plist"]

#define AUTO(width) [UIScreen convert320ToCurrentWidth:width]
//用在block里面
#define WEAKSELF __weak __typeof(&*self)weakSelf_SC = self;
//字体
#define FONT(float) [UIFont systemFontOfSize:float]
//RGB颜色
#define COLOR_RGB(R,G,B) [UIColor WTcolorWithRed:R green:G blue:B]

//颜色和透明度设置
#define RGBA(r,g,b,a)    [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
//16进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//屏幕宽高
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height