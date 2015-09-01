//
//  DBManager.m
//  CookMenu
//
//  Created by Sincere on 15/5/2.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "RecipeModel.h"


@implementation DBManager

static FMDatabase *fmdb = nil;


//创建FMDatabase对象
+ (void)creatDB
{
    //    通过指定SQLite数据库文件路径来创建FMDatabase对象
    fmdb = [FMDatabase databaseWithPath:[self dataPath]];
    
}
// 指定路径
+ (NSString *)dataPath
{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"meishi" ofType:@"db"];
    

    return path;
    
}


//获得所有的对象

+ (NSArray *)getRecipeWithSQL:(NSString *)sqlStr recorder:(NSString *)recorderStr
{
    if (recorderStr == nil) {
        recorderStr = @"order by onclick desc";
    }
    [self creatDB];
    if (![fmdb open])
    {
        NSAssert(0, @"打开失败");
    }
    [fmdb setShouldCacheStatements:YES];
    
    
    if (![fmdb tableExists:@"recipe"]) {
        return nil;
    }
    
    //查询contact表中所有的数据
    FMResultSet *resultSet = [fmdb executeQuery:[NSString stringWithFormat:@"select * from recipe %@ %@",sqlStr,recorderStr]];
    //创建数组来接收内容
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    //    遍历结果集   每一次[resultSet next] 相当于取下一条数据
    while ([resultSet next])
    {
        //        把当前记录的值赋给对象的属性
        RecipeModel *recipe = [[RecipeModel alloc] init];
        recipe.scene = [resultSet stringForColumn:@"scene"];
        recipe.tools = [resultSet stringForColumn:@"tools"];
        recipe.menuId = [resultSet intForColumn:@"id"];
        recipe.title = [resultSet stringForColumn:@"title"];
        recipe.onclick = [resultSet intForColumn:@"onclick"];
        recipe.fav_num = [resultSet intForColumn:@"fav_num"];
        recipe.photo_num = [resultSet intForColumn:@"photo_num"];
        recipe.href = [resultSet stringForColumn:@"href"];
        recipe.classname = [resultSet stringForColumn:@"classname"];
        recipe.bclassname = [resultSet stringForColumn:@"bclassname"];
        recipe.kouwei = [resultSet stringForColumn:@"kouwei"];
        recipe.gongyi = [resultSet stringForColumn:@"gongyi"];
        recipe.make_time = [resultSet stringForColumn:@"make_time"];
        recipe.make_time_num = [resultSet intForColumn:@"make_time_num"];
        recipe.make_diff = [resultSet stringForColumn:@"make_diff"];
        recipe.make_pretime = [resultSet stringForColumn:@"make_pretime"];
        recipe.make_amount = [resultSet stringForColumn:@"make_amount"];
        recipe.step = [resultSet intForColumn:@"step"];
        recipe.titlepic = [resultSet stringForColumn:@"titlepic"];
        
        recipe.smalltext = [resultSet stringForColumn:@"smalltext"];
        recipe.is_recipe = [resultSet intForColumn:@"is_recipe"];
        recipe.author = [resultSet stringForColumn:@"author"];
        recipe.newsphoto = [resultSet stringForColumn:@"newsphoto"];
        recipe.newsphoto_h = [resultSet intForColumn:@"newsphoto_h"];
        recipe.liaos = [resultSet stringForColumn:@"liaos"];
        recipe.zuofa = [resultSet stringForColumn:@"zuofa"];
        recipe.tips = [resultSet stringForColumn:@"tips"];
        recipe.yyxx = [resultSet stringForColumn:@"yyxx"];
        
        
        //        把当前这条记录所对应的contact数据放到数组里
        [array addObject:recipe];
        
    }
    NSLog(@"======%@",array);
    
    [resultSet close];
    [fmdb close];
    
    return array;
}


@end
