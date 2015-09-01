//
//  MenuListCell.m
//  CookMenu
//
//  Created by Sincere on 15/5/2.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "MenuListCell.h"
#import "CookMenu_Header.h"
@interface MenuListCell()
{
    UIImageView *titleImageView;
    UILabel *titleLabel;
    
    UIImageView *stepImageView;
    UIImageView *kouweiImageView;
    
    UILabel *stepTimeLabel;
    UILabel *kouweiLabel;
    UILabel *detailLabel;//描述
}
@end
@implementation MenuListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = COLOR_RGB(234, 234, 234);
        titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 90.0f, 90.0f)];
        titleImageView.contentMode = UIViewContentModeScaleAspectFill;
        titleImageView.layer.cornerRadius = 2.0f;
        titleImageView.layer.masksToBounds = YES;
        [self addSubview:titleImageView];
        
        CGFloat x = titleImageView.frame.origin.x+titleImageView.frame.size.width+10.0f;
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 10.0f, SCREEN_WIDTH-x-10.0f, 40.0f)];
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = COLOR_RGB(21, 21, 21);
        titleLabel.font = FONT(16.0f);
        [self addSubview:titleLabel];
        
        stepImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, titleLabel.frame.origin.y+titleLabel.frame.size.height, 18.0f, 18.0f)];
        stepImageView.image = [UIImage imageNamed:@"nd_icon_36.png"];
        [self addSubview:stepImageView];
        stepTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x+stepImageView.frame.size.width+5.0f, stepImageView.frame.origin.y, 200.0f, 18.0f)];
        stepTimeLabel.textColor = COLOR_RGB(136, 136, 136);
        stepTimeLabel.font = FONT(14.0f);
        [self addSubview:stepTimeLabel];
        
        kouweiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, stepImageView.frame.origin.y+stepImageView.frame.size.height, 18.0f, 18.0f)];
        kouweiImageView.image = [UIImage imageNamed:@"sx_icon_36.png"];
//        [self addSubview:kouweiImageView];
        kouweiLabel = [[UILabel alloc] initWithFrame:CGRectMake(x+kouweiImageView.frame.size.width+5.0f, kouweiImageView.frame.origin.y, 200.0f, 18.0f)];
        kouweiLabel.textColor = COLOR_RGB(136, 136, 136);
        kouweiLabel.font = FONT(14.0f);
//        [self addSubview:kouweiLabel];
        
        detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, titleLabel.frame.origin.y+titleLabel.frame.size.height, SCREEN_WIDTH-x-10.0f, 40.0f)];
        detailLabel.textColor = COLOR_RGB(136, 136, 136);
        detailLabel.numberOfLines = 0;
        detailLabel.font = FONT(14.0f);
//        [self addSubview:detailLabel];
        
    }
    return self;
}
- (void)loadingMenuListWith:(RecipeModel *)recipe
{
    titleLabel.text = recipe.title;
    [titleImageView sd_setImageWithURL:[NSURL URLWithString:recipe.titlepic] placeholderImage:[UIImage imageNamed:@"imageBackground.png"]];
    
    [self removeLabelAndeImageView];
    if (recipe.gongyi.length == 0)
    {
        
        [self addSubview:detailLabel];
        NSData* stringData = [recipe.zuofa dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *zuofanArray = [NSJSONSerialization JSONObjectWithData:stringData options:NSJSONReadingMutableLeaves error:nil];
        
        NSString *detailString;
        if ([zuofanArray[0] objectForKey:@"h"]==nil) {
            detailString = [NSString stringWithFormat:@"%@%@",[zuofanArray[0] objectForKey:@"d"],[zuofanArray[1] objectForKey:@"d"]];
        }else
        {
            detailString = [NSString stringWithFormat:@"%@%@",[zuofanArray[1] objectForKey:@"d"],[zuofanArray[2] objectForKey:@"d"]];
        }
        

        detailLabel.text = [detailString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSLog(@"123");
    }else
    {
        [self addSubview:stepImageView];
        [self addSubview:stepTimeLabel];
        [self addSubview:kouweiImageView];
        [self addSubview:kouweiLabel];
        stepTimeLabel.text = [NSString stringWithFormat:@"%d步/%@",recipe.step,recipe.make_time];
        kouweiLabel.text = [NSString stringWithFormat:@"%@/%@",recipe.kouwei,recipe.gongyi];
    }
    self.selectionStyle = UITableViewCellAccessoryNone;
    if ([self respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    if([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [self setPreservesSuperviewLayoutMargins:NO];
    }
}

- (void)removeLabelAndeImageView
{
    [stepImageView removeFromSuperview];
    [stepTimeLabel removeFromSuperview];
    [kouweiImageView removeFromSuperview];
    [kouweiLabel removeFromSuperview];
    [detailLabel removeFromSuperview];
}

@end
