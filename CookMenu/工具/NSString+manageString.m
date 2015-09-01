//
//  NSString+manageString.m
//  CookMenu
//
//  Created by Sincere on 15/5/3.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "NSString+manageString.h"

@implementation NSString (manageString)
+ (NSString *)stringWithTrimmingCharactersInSet:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
@end
