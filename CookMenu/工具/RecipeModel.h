//
//  RecipeModel.h
//  CookMenu
//
//  Created by Sincere on 15/5/2.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString * scene;
@property (nonatomic, copy) NSString * tools;
@property (nonatomic) int menuId;
@property (nonatomic, copy) NSString * title;
@property (nonatomic) int onclick;
@property (nonatomic) int fav_num;
@property (nonatomic) int photo_num;
@property (nonatomic, copy) NSString * href;
@property (nonatomic, copy) NSString * classname;
@property (nonatomic, copy) NSString * bclassname;
@property (nonatomic, copy) NSString * fclassname;
@property (nonatomic, copy) NSString * kouwei;
@property (nonatomic, copy) NSString * gongyi;
@property (nonatomic, copy) NSString * make_time;
@property (nonatomic) int make_time_num;
@property (nonatomic, copy) NSString * make_diff;
@property (nonatomic, copy) NSString * make_pretime;
@property (nonatomic, copy) NSString * make_amount;
@property (nonatomic) int step;
@property (nonatomic, copy) NSString * titlepic;
@property (nonatomic, copy) NSString * smalltext;
@property (nonatomic) int is_recipe;
@property (nonatomic, copy) NSString * author;
@property (nonatomic, copy) NSString * newsphoto;
@property (nonatomic) int newsphoto_h;
@property (nonatomic, copy) NSString * liaos;
@property (nonatomic, copy) NSString * zuofa;
@property (nonatomic, copy) NSString * tips;
@property (nonatomic, copy) NSString * yyxx;
@end
