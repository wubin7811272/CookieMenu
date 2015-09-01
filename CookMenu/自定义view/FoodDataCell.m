//
//  FoodDataCell.m
//  CookMenu
//
//  Created by mac on 15/5/6.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "FoodDataCell.h"
#import "CookMenu_Header.h"
@interface FoodDataCell()
{
    UILabel *titleLabel;//分类标题
    UIView *dataView;//材料页面
    CGFloat _buttonWidth;
    CGFloat _intervalX;
}
@end
@implementation FoodDataCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xeeeeee);
        _buttonWidth = AUTO(72.0f);
        _intervalX = (SCREEN_WIDTH - 20.0f - 4*_buttonWidth)/3;
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, _buttonWidth, _buttonWidth)];
        titleLabel.backgroundColor = UIColorFromRGB(0xff5151);
        titleLabel.font = FONT(15.0f);
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        dataView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width+_intervalX, 0.0f, SCREEN_WIDTH-20.0f-_buttonWidth-_intervalX, 0)];
        [self addSubview:dataView];
    }
    return self;
}
- (void)loadingFoodDataWithDict:(NSDictionary *)dataDict
{
    for (UIView *view in [dataView subviews]) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            [label removeFromSuperview];
            label = nil;
        }
    }
    titleLabel.text = dataDict[@"t"];
    NSArray *dataArr = dataDict[@"d"];
    CGFloat dataViewHeight = 0.0f;
    for (int i=0; i<dataArr.count; i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((i%3)*(_intervalX+_buttonWidth), (i/3)*(_intervalX+_buttonWidth), _buttonWidth, _buttonWidth)];
        label.backgroundColor = UIColorFromRGB(0xdddddd);
        label.textColor = UIColorFromRGB(0xa0a0a0a);
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.font = FONT(15.0f);
        NSObject *object = dataArr[i];
        if ([object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *a = (NSDictionary *)object;
            label.text = a[@"t"];
        }else
        {
            NSString *str = (NSString *)object;
            label.text = str;
        }
        
        [dataView addSubview:label];
        dataViewHeight = (i/3)*(_intervalX+_buttonWidth)+(_intervalX+_buttonWidth);
    }
    dataView.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width+_intervalX, 0.0f, SCREEN_WIDTH-20.0f-_buttonWidth-_intervalX, dataViewHeight);
    self.foodDataTableRowHeight = dataViewHeight;
    self.selectionStyle = UITableViewCellAccessoryNone;
}
@end
