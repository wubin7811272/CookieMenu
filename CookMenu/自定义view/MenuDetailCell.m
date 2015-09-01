//
//  MenuDetailCell.m
//  CookMenu
//
//  Created by Sincere on 15/5/3.
//  Copyright (c) 2015年 吴斌. All rights reserved.
//

#import "MenuDetailCell.h"
#import "CookMenu_Header.h"
@interface MenuDetailCell()
{
    UIImageView *detailImageView;//图片
    UILabel *detailLabel;//文字
}
@end
@implementation MenuDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = COLOR_RGB(234, 234, 234);
        
        detailImageView = [[UIImageView alloc] init];
        detailImageView.layer.cornerRadius = 2.0f;
        detailImageView.layer.masksToBounds = YES;
        
        detailLabel = [[UILabel alloc] init];
        detailLabel.textColor = COLOR_RGB(50, 50, 50);
        detailLabel.numberOfLines = 0;
        detailLabel.font = FONT(17.0f);
    }
    return  self;
}
- (void)loadingDetailMenuWithDict:(NSDictionary *)detailDict
{
    [self removeAllControl];
    if (detailDict[@"h"]==nil)
    {
        [self addSubview:detailLabel];
        NSString *string = [NSString stringWithTrimmingCharactersInSet:detailDict[@"d"]];
        CGFloat stringHeight = [UILabel height:string widthOfFatherView:SCREEN_WIDTH-20.0f textFont:FONT(17.0f)];
        detailLabel.frame = CGRectMake(10.0f, 10.0f, SCREEN_WIDTH-20.0f, stringHeight);
        detailLabel.text = string;
        self.detailTableRowHeight = stringHeight+20.0f;
    }else
    {
        [self addSubview:detailImageView];
        CGSize imageSize = CGSizeMake([detailDict[@"w"] floatValue], [detailDict[@"h"] floatValue]);
        CGFloat imageHeight = [self height:imageSize widthOfFatherView:SCREEN_WIDTH-20.0f];
        detailImageView.frame = CGRectMake(10.0f, 10.0f, SCREEN_WIDTH-20.0f, imageHeight);
        [detailImageView sd_setImageWithURL:[NSURL URLWithString:detailDict[@"d"]] placeholderImage:[UIImage imageNamed:@"imageBackground.png"]];

        self.detailTableRowHeight = imageHeight+20.0f;
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)removeAllControl
{
    [detailImageView removeFromSuperview];
    [detailLabel removeFromSuperview];
}

- (CGFloat)height:(CGSize)imageSize widthOfFatherView:(CGFloat)width
{
    CGSize size = CGSizeMake(width, (width/imageSize.width)*imageSize.height);
    return size.height;
}
@end
