//
//  RecipeModel.m
//  CookMenu
//
//  Created by Sincere on 15/5/2.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "RecipeModel.h"

@implementation RecipeModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.scene forKey:@"scene"];
    [aCoder encodeObject:self.tools forKey:@"tools"];
    [aCoder encodeInt:self.menuId forKey:@"menuId"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeInt:self.onclick forKey:@"onclick"];
    [aCoder encodeInt:self.fav_num forKey:@"fav_num"];
    [aCoder encodeInt:self.photo_num forKey:@"photo_num"];
    [aCoder encodeObject:self.href forKey:@"href"];
    [aCoder encodeObject:self.classname forKey:@"classname"];
    [aCoder encodeObject:self.bclassname forKey:@"bclassname"];
    [aCoder encodeObject:self.fclassname forKey:@"fclassname"];
    [aCoder encodeObject:self.kouwei forKey:@"kouwei"];
    [aCoder encodeObject:self.gongyi forKey:@"gongyi"];
    [aCoder encodeObject:self.make_time forKey:@"make_time"];
    [aCoder encodeInt:self.make_time_num forKey:@"make_time_num"];
    [aCoder encodeObject:self.make_diff forKey:@"make_diff"];
    [aCoder encodeObject:self.make_pretime forKey:@"make_pretime"];
    [aCoder encodeObject:self.make_amount forKey:@"make_amount"];
    [aCoder encodeInt:self.step forKey:@"step"];
    [aCoder encodeObject:self.titlepic forKey:@"titlepic"];
    [aCoder encodeObject:self.smalltext forKey:@"smalltext"];
    [aCoder encodeInt:self.is_recipe forKey:@"is_recipe"];
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.newsphoto forKey:@"newsphoto"];
    [aCoder encodeInt:self.newsphoto_h forKey:@"newsphoto_h"];
    [aCoder encodeObject:self.liaos forKey:@"liaos"];
    [aCoder encodeObject:self.zuofa forKey:@"zuofa"];
    [aCoder encodeObject:self.tips forKey:@"tips"];
    [aCoder encodeObject:self.yyxx forKey:@"yyxx"];
}
//Decoder 解码 反序列化
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.scene = [aDecoder decodeObjectForKey:@"scene"];
        self.tools = [aDecoder decodeObjectForKey:@"tools"];
        self.menuId = [aDecoder decodeIntForKey:@"menuId"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.onclick = [aDecoder decodeIntForKey:@"onclick"];
        self.fav_num = [aDecoder decodeIntForKey:@"fav_num"];
        self.photo_num = [aDecoder decodeIntForKey:@"photo_num"];
        self.href = [aDecoder decodeObjectForKey:@"href"];
        self.classname = [aDecoder decodeObjectForKey:@"classname"];
        self.bclassname = [aDecoder decodeObjectForKey:@"bclassname"];
        self.fclassname = [aDecoder decodeObjectForKey:@"fclassname"];
        self.kouwei = [aDecoder decodeObjectForKey:@"kouwei"];
        self.gongyi = [aDecoder decodeObjectForKey:@"gongyi"];
        self.make_time = [aDecoder decodeObjectForKey:@"make_time"];
        self.make_time_num = [aDecoder decodeIntForKey:@"make_time_num"];
        self.make_diff = [aDecoder decodeObjectForKey:@"make_diff"];
        self.make_pretime = [aDecoder decodeObjectForKey:@"make_pretime"];
        self.make_amount = [aDecoder decodeObjectForKey:@"make_amount"];
        self.step = [aDecoder decodeIntForKey:@"step"];
        self.titlepic = [aDecoder decodeObjectForKey:@"titlepic"];
        self.smalltext = [aDecoder decodeObjectForKey:@"smalltext"];
        self.is_recipe = [aDecoder decodeIntForKey:@"is_recipe"];
        self.author = [aDecoder decodeObjectForKey:@"author"];
        self.newsphoto = [aDecoder decodeObjectForKey:@"newsphoto"];
        self.newsphoto_h = [aDecoder decodeIntForKey:@"newsphoto_h"];
        self.liaos = [aDecoder decodeObjectForKey:@"liaos"];
        self.zuofa = [aDecoder decodeObjectForKey:@"zuofa"];
        self.tips = [aDecoder decodeObjectForKey:@"tips"];
        self.yyxx = [aDecoder decodeObjectForKey:@"yyxx"];
    }
    return self;
}

@end
