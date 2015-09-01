//
//  DBManager.h
//  CookMenu
//
//  Created by Sincere on 15/5/2.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RecipeModel;
@interface DBManager : NSObject

+ (void)creatTable;

+ (NSArray *)getRecipeWithSQL:(NSString *)sqlStr recorder:(NSString *)recorderStr;

+ (void)deleteContact:(NSString *)contactId;
@end
